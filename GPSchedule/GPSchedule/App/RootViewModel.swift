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

// sourcery: store = RootStore
class RootViewModel: ViewReactor {

    // sourcery: defaultState = "logIn"
    enum State: ViewState {
        case logIn
        case loggedIn
        case loading
        case error(Error)

        enum UserAction {
            case bussy
        }

        init(){
            self = .logIn
        }
    }

    // sourcery:inline:RootViewModel.ViewReactor
    let store: RootStore
    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State())
    
    required init(store: RootStore) {
        self.store = store
    }
    // sourcery:end
}

extension RootViewModel: ViewStateReducer {
    func reduce(state: State, action: State.UserAction) -> State {
        return state
    }
}

extension RootViewModel: ViewStateTransformer {
    func transform(storeState: RootState, state: State) -> State {
        switch storeState.rootState {
        case .unauthorized:
            return .logIn
        case .authorized:
            return .loggedIn
        case .error(let error):
            return .error(error)
        }
    }

    func transform(store state: RootState) -> State {
        return State()
    }
}
