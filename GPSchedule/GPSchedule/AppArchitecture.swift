//
//  AppArchitecture.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 09/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Abstract declarations
// MARK: Business Domain
/*
 responsibility: 
*/

protocol DomainModel {
    var id: String { get }
}

protocol AbstractEvent {}
protocol AbstractState {}

protocol DomainEvent: AbstractEvent {}
protocol DomainState: AbstractState, Equatable {
    associatedtype StateEvent: DomainEvent, Equatable
}

protocol DomainStore: class {
    associatedtype State: DomainState

    var state: BehaviorSubject<State> { get }

    init(initialState: State,
         warehouse: DomainStoreFacade?,
         reducer: @escaping DomaninStateReducer<State>,
         middleware: [DomainStateMiddleware<State>],
         feedbackLoop: [DomainStateFeedback<State>])

    func dispatch(event: State.StateEvent)
}

typealias DomaninStateReducer<State: DomainState> = (State, State.StateEvent) -> State
typealias DomainStateFeedback<State: DomainState> = (State) -> Observable<DomainEvent>
typealias DomainStateMiddleware<State: DomainState> = (State.StateEvent) -> Observable<State.StateEvent>

protocol ServiceCommand {
    associatedtype Model: DomainModel
    func execute() -> Single<Model>
}

protocol ServiceProvider: class {}

protocol DomainStoreFacade: class {
    var state: BehaviorSubject<AbstractState> { get }

    func getStore<S>(for type: S.Type) -> S
    func dispatch(event: DomainEvent)
}

// MARK: Presentation Domain
protocol ViewState: Equatable {
    associatedtype UserAction: AbstractEvent, Equatable

    init()
}

typealias ViewStateTransformer<StoreState: DomainState, State: ViewState> = (StoreState, State) -> State
typealias ViewStateReducer<State: ViewState> = (State, State.UserAction) -> State

protocol ViewReactor: class {
    associatedtype State: ViewState
    associatedtype Store: DomainStore

    var store: Store! { get }
    var action: PublishSubject<State.UserAction> { get }
    var state: BehaviorSubject<State> { get }

    init(warehouse: DomainStoreFacade,
         transformer: ViewStateTransformer<Store.State, State>?,
         reducer: ViewStateReducer<State>?)
}

protocol ChildViewReactor: ViewReactor {
    associatedtype Parent: ViewReactor

    init(parent: Parent,
         transformer: ViewStateTransformer<Store.State, State>?,
         reducer: ViewStateReducer<State>?)
}

// MARK: Platform Domain
protocol AppView: class {
    associatedtype ViewModel: ViewReactor

    init(viewModel: ViewModel)
}

// MARK: Implementations
import UIKit

enum InitialState: AbstractState {
    case uninitialized

    init() {
        self = .uninitialized
    }
}

protocol AppError: Error {} // should I make it Equatable?

extension Array: DomainModel where Element: DomainModel {
    var id: String {
        return self.reduce(into: "", { $0 += $1.id })
    }
}

class GenericUseCase<State: DomainState>: DomainStore {

    static func dummyMiddleware(event: State.StateEvent) -> Observable<State.StateEvent> {
        return Observable.just(event)
    }
    
    var state: BehaviorSubject<State>
    private weak var warehouse: DomainStoreFacade?
    private var currentState: State
    private let events = PublishSubject<State.StateEvent>()
    private let reduce: DomaninStateReducer<State>
    private let middlewares: [DomainStateMiddleware<State>]
    private let feedbackLoops: [DomainStateFeedback<State>]
    private let disposeBag = DisposeBag()

    required init(initialState: State,
                  warehouse: DomainStoreFacade?,
                  reducer: @escaping DomaninStateReducer<State>,
                  middleware: [DomainStateMiddleware<State>] = [],
                  feedbackLoop: [DomainStateFeedback<State>] = []) {

        self.currentState = initialState
        self.warehouse = warehouse
        self.reduce = reducer
        if middleware.isEmpty {
            self.middlewares = [GenericUseCase.dummyMiddleware]
        } else {
            self.middlewares = middleware
        }
        self.feedbackLoops = feedbackLoop
        self.state = BehaviorSubject(value: initialState)

        events
            .distinctUntilChanged() // that may not always be desirable
            .map { [middlewares] event in middlewares.map { $0(event) } }
            .map { Observable.from($0).merge() }.merge()
            .map { [reduce, currentState] in reduce(currentState, $0) }
            .bind(to: state)
            .disposed(by: disposeBag)

        state
            .distinctUntilChanged()
            .map { [feedbackLoops] state in feedbackLoops.map { $0(state) } }
            .map { Observable.from($0).merge() }.merge()
            .subscribe(onNext: { [weak self] (event) in
                self?.warehouse?.dispatch(event: event)
            })
            .disposed(by: disposeBag)

        state
            .distinctUntilChanged()
            .subscribeNext(weak: self, { object in
                return { object.currentState = $0
                }})
            .disposed(by: disposeBag)
    }

    func dispatch(event: State.StateEvent) {
        events.onNext(event)
    }
}

class GenericViewModel<VS: ViewState, ST: DomainStore>: ViewReactor {

    typealias State = VS
    typealias Store = ST

    weak var store: Store!
    weak var warehouse: DomainStoreFacade!
    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State.init())
    private let transform: ViewStateTransformer<Store.State, State>
    private let reduce: ViewStateReducer<State>
    private let disposableBag = DisposeBag()

    required init(warehouse: DomainStoreFacade,
                  transformer: ViewStateTransformer<Store.State, State>?,
                  reducer: ViewStateReducer<State>?) {

        func defaultViewStateTransformer<StoreState, State>(storeState: StoreState, state: State) -> State
            where StoreState: DomainState, State: ViewState {
                return state
        }

        func defaultViewStateReducer<State>(state: State, action: State.UserAction) -> State
            where State: ViewState {
                return state
        }

        self.store = warehouse.getStore(for: Store.self)
        self.warehouse = warehouse
        self.transform = transformer ?? defaultViewStateTransformer
        self.reduce = reducer ?? defaultViewStateReducer

        store.state
            .distinctUntilChanged()
            .map { [state, transform] in try transform($0, state.value()) }
            .bind(to: state)
            .disposed(by: disposableBag)

        action
            .distinctUntilChanged() // that may not always be desirable
            .map { [state, reduce] in try reduce(state.value(), $0) }
            .bind(to: state)
            .disposed(by: disposableBag)

        state
            .distinctUntilChanged()
            .subscribe(weak: self, onNext: type(of: self).forwarder, onError: type(of: self).errorHandler, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposableBag)
    }

    func forwarder(state: State) {
        return
    }

    func errorHandler(error: Error) {
        fatalError("Unhandler error")
    }
}

class GenericChildViewModel<VS: ViewState, ST: DomainStore, PT: ViewReactor>: GenericViewModel<VS, ST>, ChildViewReactor {

    typealias Parent = GenericViewModel<PT.State, PT.Store>

    weak var parent: Parent?

    required convenience init(
            parent: Parent,
            transformer: ViewStateTransformer<Store.State, State>?,
            reducer: ViewStateReducer<State>?) {
        self.init(warehouse: parent.warehouse, transformer: transformer, reducer: reducer)
        self.parent = parent
    }

    required init(warehouse: DomainStoreFacade,
                  transformer: ViewStateTransformer<Store.State, State>?,
                  reducer: ViewStateReducer<State>?) {
        super.init(warehouse: warehouse, transformer: transformer, reducer: reducer)
    }
}

class GenericViewController<VM: ViewReactor>: UIViewController, AppView {

    typealias ViewModel = VM

    private(set) var viewModel: ViewModel
    private(set) var disposeBag = DisposeBag()

    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindToViewModel()
    }

    func setupView() {
        return
    }

    func bindToViewModel() {
        viewModel.state
            .subscribe(
                weak: self,
                onNext: { return $0.process },
                onError: { (_) -> (Error) -> Void in fatalError("Unhandled error has occured") },
                onCompleted: { (_) -> () -> Void in fatalError("Root state must not compleate while application is running") },
                onDisposed: { (_) -> () -> Void in fatalError("Root state must not be disposed while application is running") })
            .disposed(by: disposeBag)
    }

    func process(state: ViewModel.State) {
        return
    }
}
