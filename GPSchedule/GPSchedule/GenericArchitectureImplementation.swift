//
//  GenericArchitectureImplementation.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 18/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Generic Implementations
import UIKit

enum InitialState: AbstractState {

    case uninitialized

    init() {
        self = .uninitialized
    }
}

protocol AppError: AbstractError {}

extension DomainEvent where Self: Equatable {

    func isEqualTo(_ other: DomainEvent) -> Bool {
        guard let otherEvent = other as? Self else {
            return false
        }
        return self == otherEvent
    }
}

// MARK: Bussiness Domain
class GenericUseCase<State: DomainState>: DomainStore {

    var state: StateRelay<State>
    private let events = EventRelay<State.StateEvent>()

    private weak var warehouse: DomainStoreFacade?
    private let reduce: DomainStateReducer<State>
    private let middlewares: [DomainStateMiddleware<State>]
    private let feedbackLoops: [DomainStateFeedback<State>]
    private let disposeBag = DisposeBag()

    required init(warehouse: DomainStoreFacade?,
                  reducer: @escaping DomainStateReducer<State>,
                  middleware: [DomainStateMiddleware<State>] = [],
                  feedbackLoop: [DomainStateFeedback<State>] = []) {

        func passthruMiddleware(event: State.StateEvent) -> Observable<State.StateEvent> {
            return Observable.just(event)
        }

        let initialState = State.init()
        self.warehouse = warehouse
        self.reduce = reducer
        self.middlewares = middleware.isEmpty ? [passthruMiddleware] : middleware
        self.feedbackLoops = feedbackLoop
        self.state = StateRelay(value: initialState)

        events
            .map { [middlewares] event in middlewares.map { $0(event) } }
            .map { Observable.from($0).merge() }.merge()
            .withLatestFrom(state) { return ($1, $0) }
            .map { [reduce] in reduce($0.0, $0.1) }
            .distinctUntilChanged()
            .subscribe(weak: self, { object in return object.eventStreamHandler })
            .disposed(by: disposeBag)

        // delay is due to the last `event` not yet being registered at the time of the new `state` event
        state
            .delay(0.1, scheduler: MainScheduler.instance)
            .map { [feedbackLoops] state in feedbackLoops.map { $0(state) } }
            .map { Observable.from($0).merge() }.merge()
            .distinctUntilChanged { $0.isEqualTo($1) }
            .do(onNext: { [warehouse] (event) in warehouse?.dispatch(event: event) })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func dispatch(event: State.StateEvent) {
        events.accept(event)
    }

    private func eventStreamHandler(rxEvent: Event<State>) {
        switch rxEvent {
        case .next(let newState):
            state.accept(newState)
        case .error(let error):
            fatalError("Use case encountered unhandled error")
        case .completed:
            fatalError("Event stream must not be compleated while UseCase is alive")
        }
    }
}

// MARK: Presentation Domain
class GenericViewModel<VS: ViewState, ST: DomainStore>: ViewReactor {

    typealias State = VS
    typealias Store = ST

    let state: StateRelay<State>
    let action = EventRelay<State.UserAction>()

    weak var store: Store!
    weak var warehouse: DomainStoreFacade!
    private let transform: ViewStateTransformer<Store.State, State>
    private let reduce: ViewStateReducer<State>
    private let forward: ViewStateForwarder<State>
    private let disposeBag = DisposeBag()

    required init(warehouse: DomainStoreFacade,
                  transformer: ViewStateTransformer<Store.State, State>?,
                  reducer: ViewStateReducer<State>?,
                  forwarder: ViewStateForwarder<State>?) {

        func defaultViewStateTransformer<StoreState, State>(storeState: StoreState, state: State) -> State
            where StoreState: DomainState, State: ViewState {
                return state
        }

        func defaultViewStateReducer<State>(state: State, action: State.UserAction) -> State
            where State: ViewState {
                return state
        }

        func defaultViewStateForwarder(self: AnyObject?, state: State, action: State.UserAction) -> Void {
            return
        }

        let initialState = State.init()
        self.state = StateRelay(value: initialState)
        self.store = warehouse.getStore(for: Store.self)
        self.warehouse = warehouse
        self.transform = transformer ?? defaultViewStateTransformer
        self.reduce = reducer ?? defaultViewStateReducer
        self.forward = forwarder ?? defaultViewStateForwarder

        let transformedState = store
            .state
            .distinctUntilChanged()
            .withLatestFrom(state) { ($0, $1) }
            .map { [transform] in transform($0.0, $0.1) }
            .distinctUntilChanged()

        let reducedState = action
            .withLatestFrom(state) { ($1, $0) }
            .map { [reduce] in reduce($0.0, $0.1) }
            .distinctUntilChanged()

        Observable
            .merge(transformedState, reducedState)
            .distinctUntilChanged()
            .subscribe(weak: self, { object in return object.stateStreamHandler })
            .disposed(by: disposeBag)

        // delay is due to the last `action` event not yet being registered at the time of the new `state` event
        state
            .delay(0.1, scheduler: MainScheduler.instance)
            .withLatestFrom(action, resultSelector: { return ($0, $1) })
            .do(onNext: { [weak self] in self?.forward(self, $0.0, $0.1) })
            .subscribe()
            .disposed(by: disposeBag)

    }

    final func dispatch(action: State.UserAction) {
        self.action.accept(action)
    }

    private func stateStreamHandler(rxEvent: Event<State>) {
        switch rxEvent {
        case .next(let newState):
            state.accept(newState)
        case .error:
            fatalError("Unhandled error")
        case .completed:
            fatalError("Event stream must not be compleated while UseCase is alive")
        }
    }
}

class GenericChildViewModel<VS: ViewState, ST: DomainStore, PT: ViewReactor>: GenericViewModel<VS, ST>, ChildViewReactor {

    typealias Parent = GenericViewModel<PT.State, PT.Store>

    weak var parent: Parent!

    required convenience init(
        parent: Parent,
        transformer: ViewStateTransformer<Store.State, State>?,
        reducer: ViewStateReducer<State>?,
        forwarder: ViewStateForwarder<State>?) {
        self.init(warehouse: parent.warehouse, transformer: transformer, reducer: reducer, forwarder: forwarder)
        self.parent = parent
    }

    required init(warehouse: DomainStoreFacade,
                  transformer: ViewStateTransformer<Store.State, State>?,
                  reducer: ViewStateReducer<State>?,
                  forwarder: ViewStateForwarder<State>?) {
        super.init(warehouse: warehouse, transformer: transformer, reducer: reducer, forwarder: forwarder)
    }
}

// MARK: Platform Domain
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
        viewModel
            .state
            .distinctUntilChanged()
            .subscribeNext(weak: self, { object in return object.process })
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

extension Array: DomainModel where Element: DomainModel {

    var id: String {
        return self.reduce(into: "", { $0 += $1.id })
    }
}
