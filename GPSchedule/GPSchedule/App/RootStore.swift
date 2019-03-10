//
//  RootStore.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 09/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class RootState: DomainState {
    enum State {
        case unauthorized(error: String?)
        case authorized
        case error(Error)
    }

    enum Event {
        case login(username: String, password: String)
        case logout
        case error(Error)
    }

    let rootState: State

    init() {
        self.rootState = .unauthorized(error: nil)
    }
}

struct RootUseCase: DomaninStateReducer {
    func reduce(state: RootState, event: RootState.Event) -> RootState {
        return state
        // sourcer :inline:RootState.Event.Switch
        // sourcer :end
    }
}

class RootStore: DomainStateStore {

    let state: BehaviorSubject<RootState>
    private var currentState: RootState
    private let reducer: RootUseCase

    required init(initialState: RootState, reducer: RootUseCase) {
        self.currentState = initialState
        self.reducer = reducer
        self.state = BehaviorSubject(value: initialState)
    }

    func dispatch(event: RootState.Event) {
        state.onNext(reducer.reduce(state: currentState, event: event))
    }
}
