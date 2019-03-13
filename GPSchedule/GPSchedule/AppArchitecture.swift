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

protocol DomainModel {}
protocol Event {}
protocol PureState {}
protocol DomainState: PureState, Equatable {
    associatedtype DomainEvent: Event, Equatable
}

protocol DomainStore: class {
    associatedtype State: DomainState

    var state: BehaviorSubject<State> { get }

    init(initialState: State,
         reducer: @escaping DomaninStateReducer<State>,
         middlewares: [DomainStateMiddleware<State>],
         feedbackLoops: [DomainStateFeedback<State>])

    func dispatch(event: State.DomainEvent)
}

typealias DomaninStateReducer<State: DomainState> = (State, State.DomainEvent) -> State
typealias DomainStateFeedback<State: DomainState> = (State) -> Observable<State.DomainEvent>
//typealias DomainStateMiddleware<State: DomainState> = (ServiceCommand) -> (State.DomainEvent) -> Observable<State.DomainEvent>
typealias DomainStateMiddleware<State: DomainState> = (State.DomainEvent) -> Observable<State.DomainEvent>

protocol ServiceCommand {
    associatedtype Model: DomainModel
    func execute() -> Single<Model>
}

protocol ServiceProvider: class {}

protocol DomainStoreFacade {
    func dispatch(event: Event)
}

// MARK: Presentation Domain
protocol ViewState: Equatable {
    associatedtype UserAction: Event, Equatable

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

    init(store: Store,
         transformer: ViewStateTransformer<Store.State, State>?,
         reducer: ViewStateReducer<State>?)
}

protocol ChildViewReactor: ViewReactor {
    associatedtype Parent: ViewReactor where Parent.Store == Store

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

protocol AppError: Error {} // should I make it Equatable?

class GenericUseCase<State: DomainState>: DomainStore {

    var state: BehaviorSubject<State>
    private var currentState: State
    private let events = PublishSubject<State.DomainEvent>()
    private let reduce: DomaninStateReducer<State>
    private let middlewares: [DomainStateMiddleware<State>]
    private let feedbackLoops: [DomainStateFeedback<State>]
    private let disposeBag = DisposeBag()

    required init(initialState: State,
                  reducer: @escaping DomaninStateReducer<State>,
                  middlewares: [DomainStateMiddleware<State>] = [],
                  feedbackLoops: [DomainStateFeedback<State>] = []) {
        self.currentState = initialState
        self.reduce = reducer
        self.middlewares = middlewares
        self.feedbackLoops = feedbackLoops
        self.state = BehaviorSubject(value: initialState)

        events
            .distinctUntilChanged() // that may not always be desirable
            .map { [middlewares] event in middlewares.map{ $0(event) } }
            .map { Observable.from($0).merge() }.merge()
            .map { [reduce, currentState] in reduce(currentState, $0) }
            .bind(to: state)
            .disposed(by: disposeBag)

        state
            .distinctUntilChanged()
            .map{ [feedbackLoops] state in feedbackLoops.map{ $0(state) } }
            .map { Observable.from($0).merge() }.merge()
            .bind(to: events)
            .disposed(by: disposeBag)

        state
            .distinctUntilChanged()
            .subscribeNext(weak: self, { obj in
                return { obj.currentState = $0
                }})
            .disposed(by: disposeBag)
    }

    func dispatch(event: State.DomainEvent) {
        events.onNext(event)
    }
}

class GenericViewModel<VS: ViewState, ST: DomainStore>: ViewReactor {

    typealias State = VS
    typealias Store = ST

    weak var store: Store!
    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State.init())
    private let transform: ViewStateTransformer<Store.State, State>
    private let reduce: ViewStateReducer<State>
    private let disposableBag = DisposeBag()

    required init(store: Store,
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

        self.store = store
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
            .subscribeNext(weak: self, type(of: self).forwarder)
            .disposed(by: disposableBag)
    }

    func forwarder(state: State) {
        return
    }
}

class GenericChildViewModel<VS: ViewState, PT: ViewReactor>: GenericViewModel<VS, PT.Store>, ChildViewReactor {

    typealias State = VS
    typealias Store = PT.Store
    typealias Parent = GenericViewModel<PT.State, Store>

    weak var parent:  Parent?

    required convenience init(parent: Parent,
                  transformer: ViewStateTransformer<Store.State, State>?,
                  reducer: ViewStateReducer<State>?) {
        self.init(store: parent.store, transformer: transformer, reducer: reducer)
        self.parent = parent
    }

    required init(store: Store,
                  transformer: ViewStateTransformer<Store.State, State>?,
                  reducer: ViewStateReducer<State>?) {
        super.init(store: store, transformer: transformer, reducer: reducer)
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
