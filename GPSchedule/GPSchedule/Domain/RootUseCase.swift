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

enum DomainError: Error, Equatable {
    case genericError
    case errorMessage(String)
}

protocol RootUseCaseDependenciesProvider: ServiceProvider {}

enum RootState: DomainState {

    enum StateEvent: DomainEvent, Equatable {
        case loggedIn(User)
        case logout
        case error(DomainError)
    }

    case unauthorized(error: String?)
    case authorized(user: User)
    case error(DomainError)

    init() {
        self = .unauthorized(error: nil)
    }
}

// sourcery: defaultState = "RootState"
class RootUseCase: GenericUseCase<RootState> {

    static func reduce(_ state: RootState, _ event: RootState.StateEvent) -> RootState {
        switch event {
        case .loggedIn(let user):
            return .authorized(user: user)
        case .logout:
            return .unauthorized(error: nil)
        case .error:
            return .error(DomainError.genericError)
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
                  feedbackLoop: [])
    }
}
