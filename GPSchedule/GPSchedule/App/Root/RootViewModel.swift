//
//  RootViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxSwiftExt

// sourcery: defaultState = "logIn"
indirect enum RootViewState: ViewState, BasicViewGenerator {

    enum UserAction: AbstractEvent {
        case bussy
        case dissmissError
        case dissmissLoading
    }

    case logIn
    case loggedIn
    case loading(from: RootViewState)
    case error(RootState.StateError, from: RootViewState)

// sourcery:inline:auto:RootViewState.AutoInit
    init() {
        self = .logIn
    }
// sourcery:end
}

class RootViewModel: GenericViewModel<RootViewState, RootUseCase> {

    static func transform(storeState: RootState, state: State) -> State {
        switch (storeState, state) {
        case (.unauthorized, .loggedIn):
            return .logIn
        case (.authorized, .loading):
            return .loggedIn
        case (.error(let error), _):
            return .error(error, from: state)
        default:
            return state
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch (state, action) {
        case (let oldState, .bussy):
            if case .error(_, _) = oldState {
                return state
            }
            return .loading(from: state)
        case (.loading(let oldState), .dissmissLoading):
            return oldState
        case (.error(_, let oldState), .dissmissError):
            return oldState
        default:
            return state
        }
    }

    static func forward(object: AnyObject?, state: RootViewState, lastAction: RootViewState.UserAction) {
        guard let object = object as? RootViewModel else {
            return
        }
        switch (state, lastAction) {
        case (.loggedIn, .dissmissError):
            object.warehouse.dispatch(event: CalendarState.StateEvent.refresh)
        default:
            return
        }
    }

// sourcery:inline:auto:RootViewModel.AutoInit
    // swiftlint:disable all
    convenience init(warehouse: DomainStoreFacade) {
        self.init(
            initialState: State.init(),
            warehouse: warehouse,
            transformer: RootViewModel.transform,
            reducer: RootViewModel.reduce,
            forwarder: RootViewModel.forward)
    }

    required init(
            initialState: State,
            warehouse: DomainStoreFacade,
            transformer: ViewStateTransformer<Store.State, State>?,
            reducer: ViewStateReducer<State>?,
            forwarder: ViewStateForwarder<State>?) {
        super.init(
            warehouse: warehouse,
            transformer: transformer,
            reducer: reducer,
            forwarder: forwarder)
    }
    // swiftlint:enable all
// sourcery:end

}
