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
