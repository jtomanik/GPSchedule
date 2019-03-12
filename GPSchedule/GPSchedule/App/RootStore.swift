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

enum DomainError: AppError, Equatable {
    case genericError
}

class RootState: DomainState {

    enum State: Equatable {
        case unauthorized(error: String?)
        case authorized
        case error(DomainError)
    }

    enum DomainEvent: Event {
        case login(username: String, password: String)
        case logout
        case error(DomainError)
    }

    let rootState: State

    init() {
        self.rootState = .unauthorized(error: nil)
    }
}

extension RootState: Equatable {
    static func == (lhs: RootState, rhs: RootState) -> Bool {
        return lhs.rootState == rhs.rootState
    }
}

struct RootUseCase: DomaninStateReducer {
    func reduce(state: RootState, event: RootState.DomainEvent) -> RootState {
        return state
        // sourcer :inline:RootState.DomainEvent.Switch
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

    func dispatch(event: RootState.DomainEvent) {
        state.onNext(reducer.reduce(state: currentState, event: event))
    }
}
