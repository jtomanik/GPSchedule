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

protocol AbstractEvent {}
protocol AbstractState {}
protocol AbstractError: Error {}

protocol DomainModel {
    var id: String { get }
}

protocol DomainError: AbstractError {}
protocol DomainEvent: AbstractEvent {}

protocol DomainState: AbstractState, Equatable {
    associatedtype StateEvent: DomainEvent, Equatable
    associatedtype StateError: DomainError, Equatable

    init() // default state
}

protocol DomainStore: class {
    associatedtype State: DomainState

    var state: BehaviorSubject<State> { get }

    func dispatch(event: State.StateEvent)

    init(warehouse: DomainStoreFacade?,
         reducer: @escaping DomainStateReducer<State>,
         errorHandler: @escaping DomainErrorFeedback<State>,
         middleware: [DomainStateMiddleware<State>],
         feedbackLoop: [DomainStateFeedback<State>])
}

typealias DomainStateReducer<State: DomainState> = (State, State.StateEvent) -> State
typealias DomainStateFeedback<State: DomainState> = (State) -> Observable<DomainEvent>
typealias DomainStateMiddleware<State: DomainState> = (State.StateEvent) -> Observable<State.StateEvent>
typealias DomainErrorFeedback<State: DomainState> = (State, State.StateError) -> DomainEvent

protocol ServiceCommand {
    associatedtype Model: DomainModel

    func execute() -> Single<Model>
}

protocol ServiceProvider: class {}

protocol DomainStoreFacade: class {
    var state: BehaviorSubject<AbstractState> { get }

    func dispatch(event: DomainEvent)
    func getStore<S>(for type: S.Type) -> S
}

// MARK: Presentation Domain
protocol ViewState: AbstractState, Equatable {
    associatedtype UserAction: AbstractEvent, Equatable

    init() // default state
}

typealias ViewStateReducer<State: ViewState> = (State, State.UserAction) -> State
typealias ViewStateTransformer<StoreState: DomainState, State: ViewState> = (StoreState, State) -> State

protocol ViewReactor: class {
    associatedtype State: ViewState
    associatedtype Store: DomainStore

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
