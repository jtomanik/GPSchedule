//
//  AppArchitecture.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 09/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

/*
 responsibility: 
*/
protocol DomainState: class {
    associatedtype Event
}

protocol DomaninStateReducer {
    associatedtype State: DomainState
    func reduce(state: State, event: State.Event) -> State
}

protocol DomainStateFeedbackLoop {
    associatedtype State: DomainState
    func feedback(state: Observable<State>) -> Observable<State.Event>
}

protocol DomainStateStore {
    associatedtype State: DomainState
    associatedtype Reducer: DomaninStateReducer

    var state: BehaviorSubject<State> { get }

    init(initialState: State, reducer: Reducer)
    func dispatch(event: State.Event)
}

protocol ViewState {
    associatedtype UserAction
}

protocol ViewStateTransformer {
    associatedtype State: ViewState
    associatedtype Store: DomainStateStore

    func transform(store state: Store.State) -> State
}

protocol ViewStateReducer {
    associatedtype State: ViewState
    func reduce(state: State, action: State.UserAction) -> State
}

protocol ViewReactor {
    associatedtype State: ViewState
    associatedtype Store: DomainStateStore

    var store: Store { get }
    var action: PublishSubject<State.UserAction> { get }
    var state: BehaviorSubject<State> { get }

    init(store: Store)
}

protocol AppView {
    associatedtype ViewModel: ViewReactor

    var viewModel: ViewModel { get }
    init(viewModel: ViewModel)
}


