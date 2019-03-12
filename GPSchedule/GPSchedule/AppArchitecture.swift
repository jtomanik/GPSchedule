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
/*
 responsibility: 
*/
protocol Event {}

protocol DomainState: Equatable {
    associatedtype DomainEvent: Event
}

protocol DomaninStateReducer {
    associatedtype State: DomainState
    func reduce(state: State, event: State.DomainEvent) -> State
}

protocol DomainStateFeedbackLoop {
    associatedtype State: DomainState
    func feedback(state: Observable<State>) -> Observable<State.DomainEvent>
}

protocol DomainStateStore: class {
    associatedtype State: DomainState
    associatedtype Reducer: DomaninStateReducer

    var state: BehaviorSubject<State> { get }

    init(initialState: State, reducer: Reducer)
    func dispatch(event: State.DomainEvent)
}

protocol ViewState: Equatable {
    associatedtype UserAction: Event

    init()
}

protocol ViewStateTransformer {
    static func transform<StoreState: DomainState, State: ViewState>(storeState: StoreState, state: State) -> State
}

protocol ViewStateReducer {
    static func reduce<State: ViewState>(state: State, action: State.UserAction) -> State
}

protocol ViewReactor: class, ViewStateReducer, ViewStateTransformer {
    associatedtype State: ViewState
    associatedtype Store: DomainStateStore

    var store: Store! { get }
    var action: PublishSubject<State.UserAction> { get }
    var state: BehaviorSubject<State> { get }

    init(store: Store)
}

protocol ChildViewReactor: ViewReactor {
    associatedtype Parent: ViewReactor where Parent.Store == Store

    init(parent: Parent)
}

protocol AppView {
    associatedtype ViewModel: ViewReactor

    var viewModel: ViewModel { get }
    init(viewModel: ViewModel)
}


// MARK: Implementations

protocol AppError: Error {} // make it comparable?

extension ViewStateTransformer {
    static func transform<StoreState, State>(storeState: StoreState, state: State) -> State
        where StoreState: DomainState, State: ViewState {
            return state
    }
}

extension ViewStateReducer {
    static func reduce<State>(state: State, action: State.UserAction) -> State
        where State: ViewState {
            return state
    }
}

class GenericViewModel<VS: ViewState, ST: DomainStateStore>: ViewReactor, ViewStateTransformer, ViewStateReducer {

    typealias State = VS
    typealias Store = ST

    weak var store: Store!
    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State.init())
    private let disposableBag = DisposeBag()

    required init(store: Store) {
        self.store = store

        store.state
            .distinctUntilChanged()
            .map { [state] in try type(of: self).transform(storeState: $0, state: state.value()) }
            .bind(to: state)
            .disposed(by: disposableBag)

        action
            .map { [state] in try type(of: self).reduce(state: state.value(), action: $0) }
            .bind(to: state)
            .disposed(by: disposableBag)

        state
            .distinctUntilChanged()
            .subscribeNext(weak: self, type(of: self).forwarder)
            .disposed(by: disposableBag)
    }

    func forwarder<S: ViewState>(state: S) {
        return
    }
}

class GenericChildViewModel<VS: ViewState, PT: ViewReactor>: GenericViewModel<VS, PT.Store>, ChildViewReactor {

    typealias State = VS
    typealias Store = PT.Store
    typealias Parent = GenericViewModel<PT.State, Store>

    weak var parent:  Parent!

    required init(parent: Parent) {
        super.init(store: parent.store)
        self.parent = parent
    }

    required init(store: Store) {
        super.init(store: store)
    }
}
