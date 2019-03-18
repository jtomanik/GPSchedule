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
indirect enum RootViewState: ViewState {
    case logIn
    case loggedIn
    case loading(from: RootViewState)
    case error(RootState.StateError, from: RootViewState)

    enum UserAction: AbstractEvent {
        case bussy
        case dissmissError
        case dissmissLoading
    }

    init() {
        self = .logIn
    }
}

class RootViewModel: GenericViewModel<RootViewState, RootUseCase> {

    static func transform(storeState: RootState, state: State) -> State {
        switch storeState {
        case .unauthorized:
            return .logIn
        case .authorized:
            return .loggedIn
        case .error(let error):
            return .error(error, from: state)
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .bussy:
            return .loading(from: state)
        case .dissmissLoading:
            if case .loading(let oldState) = state {
                return oldState
            } else {
                return state
            }
        case .dissmissError:
            return state
        }
    }

// sourcery:inline:auto:RootViewModel.AutoInit
// swiftlint:disable all
convenience init(warehouse: DomainStoreFacade) {
    self.init(warehouse: warehouse, transformer: RootViewModel.transform, reducer: RootViewModel.reduce)
}

required init(warehouse: DomainStoreFacade, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
    super.init(warehouse: warehouse, transformer: transformer, reducer: reducer)
}
// swiftlint:enable all
// sourcery:end
}
