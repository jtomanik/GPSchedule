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
enum RootViewState: ViewState {
    case logIn
    case loggedIn
    case loading
    case error(DomainError)

    enum UserAction: Event {
        case bussy
    }

    init(){
        self = .logIn
    }
}

class RootViewModel: GenericViewModel<RootViewState, RootStore> {}

extension RootViewModel {
    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .bussy:
            return .loading
        }
    }
}

extension RootViewModel {
    static func transform(storeState: RootState, state: State) -> State {
        switch storeState.rootState {
        case .unauthorized:
            return .logIn
        case .authorized:
            return .loggedIn
        case .error(let error):
            return .error(error)
        }
    }
}
