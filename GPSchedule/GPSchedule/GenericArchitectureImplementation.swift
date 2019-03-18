//
//  GenericArchitectureImplementation.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 18/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Implementations
import UIKit

enum InitialState: AbstractState {

    case uninitialized

    init() {
        self = .uninitialized
    }
}

protocol AppError: AbstractError {}

extension Array: DomainModel where Element: DomainModel {

    var id: String {
        return self.reduce(into: "", { $0 += $1.id })
    }
}

class GenericUseCase<State: DomainState>: DomainStore {

    var state: BehaviorSubject<State>
    private weak var warehouse: DomainStoreFacade?
    private var currentState: State
    private let events = PublishSubject<State.StateEvent>()
    private let reduce: DomainStateReducer<State>
    private let exceptionHandler: DomainErrorFeedback<State>
    private let middlewares: [DomainStateMiddleware<State>]
    private let feedbackLoops: [DomainStateFeedback<State>]
    private let disposeBag = DisposeBag()

    required init(warehouse: DomainStoreFacade?,
                  reducer: @escaping DomainStateReducer<State>,
                  errorHandler: @escaping DomainErrorFeedback<State>,
                  middleware: [DomainStateMiddleware<State>] = [],
                  feedbackLoop: [DomainStateFeedback<State>] = []) {

        func passthruMiddleware(event: State.StateEvent) -> Observable<State.StateEvent> {
            return Observable.just(event)
        }

        let initialState = State.init()
        self.currentState = initialState
        self.warehouse = warehouse
        self.reduce = reducer
        self.exceptionHandler = errorHandler
        self.middlewares = middleware.isEmpty ? [passthruMiddleware] : middleware
        self.feedbackLoops = feedbackLoop
        self.state = BehaviorSubject(value: initialState)

        events
            .distinctUntilChanged() // that may not always be desirable
            .map { [middlewares] event in middlewares.map { $0(event) } }
            .map { Observable.from($0).merge() }.merge()
            .map { [reduce, currentState] in reduce(currentState, $0) }
            .asObservable()
            .subscribe(weak: self, { object in return object.eventStreamHandler })
            .disposed(by: disposeBag)

        state
            .distinctUntilChanged()
            .map { [feedbackLoops] state in feedbackLoops.map { $0(state) } }
            .map { Observable.from($0).merge() }.merge()
            .subscribe(onNext: { [warehouse] (event) in
                warehouse?.dispatch(event: event)
            })
            .disposed(by: disposeBag)
    }

    func dispatch(event: State.StateEvent) {
        events.onNext(event)
    }

    private func eventStreamHandler(rxEvent: Event<State>) {
        switch rxEvent {
        case .next(let newState):
            currentState = newState
            state.onNext(newState)
        case .error(let error):
            if let error = error as? State.StateError {
                warehouse?.dispatch(event: exceptionHandler(currentState, error))
            } else {
                fatalError("Use case encountered unhandled error")
            }
        case .completed:
            fatalError("Event stream must not be compleated while UseCase is alive")
        }
    }
}

class GenericViewModel<VS: ViewState, ST: DomainStore>: ViewReactor {

    typealias State = VS
    typealias Store = ST

    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State.init())
    weak var store: Store!
    weak var warehouse: DomainStoreFacade!
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

enum APIError: AppError {
    case backendError
    case parsingError
    case noData
}
