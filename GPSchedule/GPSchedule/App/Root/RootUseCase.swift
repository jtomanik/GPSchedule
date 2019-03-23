//
//  RootUseCase.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 09/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

protocol RootUseCaseDependenciesProvider: ServiceProvider {}

enum RootState: DomainState {

    enum StateError: DomainError, Equatable {
        case genericError
    }

    enum StateEvent: DomainEvent, Equatable {
        case loggedIn(User)
        case logout
        case error(StateError)
    }

    case unauthorized
    case authorized(user: User)
    case error(StateError)

    init() {
        self = .unauthorized
    }
}

// sourcery: defaultState = "RootState"
class RootUseCase: GenericUseCase<RootState> {

    static func reduce(_ state: RootState, _ event: RootState.StateEvent) -> RootState {
        switch (state, event) {
        case (.unauthorized, .loggedIn(let user)):
            return .authorized(user: user)
        case (_, .logout):
            return .unauthorized
        case (_, .error):
            return .error(.genericError)
        default:
            return state
        }
    }

    static func rootFeedback() -> DomainStateFeedback<RootState> {
        return { (state: RootState) -> Observable<DomainEvent> in
            if case .authorized(let user) = state {
                return Observable.just(CalendarState.StateEvent.fetchAll(for: user))
            }
            return Observable.empty()
        }
    }

    convenience init<DependenciesProvider: RootUseCaseDependenciesProvider>(
        initialState: State = RootState(),
        warehouse: DomainStoreFacade?,
        dependencyProvider: DependenciesProvider) {
        self.init(warehouse: warehouse,
                  reducer: RootUseCase.reduce,
                  middleware: [],
                  feedbackLoop: [RootUseCase.rootFeedback()])
    }
}
