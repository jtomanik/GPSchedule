//
//  AuthUseCase.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 17/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

protocol AuthService: ServiceCommand {
    static func logIn(username: String, password: String) -> Self
    func execute() -> Single<User>
}

protocol AuthServiceProvider: ServiceProvider {
    associatedtype Service: AuthService

    var authService: Service.Type { get }
}

protocol AuthUseCaseDependenciesProvider: AuthServiceProvider {}

enum AuthState: DomainState {

    enum StateError: DomainError, Equatable {
        case unauthorized
        case unknown
        case errorMessage(String)
    }

    enum StateEvent: DomainEvent, Equatable {
        case login(username: String, password: String)
        case loggedIn(User)
        case logout
        case lock
        case unlock
        case error(StateError)
    }

    case unauthorized
    case authorized(user: User)
    //        case locked(user: User)
    case authFailure(StateError)

    init() {
        self = .unauthorized
    }
}

// sourcery: defaultState = "AuthState"
class AuthUseCase: GenericUseCase<AuthState> {

    static func authMiddleware<Service: AuthService>(service: Service.Type) -> DomainStateMiddleware<AuthState> {
        return { (event: AuthState.StateEvent) -> Observable<AuthState.StateEvent> in
            guard case .login(let username, let password) = event else {
                return Observable.just(event)
            }

            return service.logIn(username: username, password: password)
                .execute()
                .map { AuthState.StateEvent.loggedIn($0) }
                .catchError { (error) -> Single<AuthState.StateEvent> in
                    guard let error = error as? APIError else {
                        return Single.just(AuthState.StateEvent.error(.unknown))
                    }
                    switch error {
                    case .backendError:
                        return Single.just(AuthState.StateEvent.error(.unauthorized))
                    default:
                        return Single.just(AuthState.StateEvent.error(.unknown))
                    }
                }
                .asObservable()
        }
    }

    static func reduce(_ state: AuthState, _ event: AuthState.StateEvent) -> AuthState {
        switch (state, event) {
        case (.unauthorized, .loggedIn(let user)):
            return .authorized(user: user)
        case (.authFailure, .loggedIn(let user)):
            return .authorized(user: user)
        case (_, .logout):
            return .unauthorized
        case (_, .error):
            return .authFailure(State.StateError.unauthorized)
        default:
            return state
        }
    }

    static func authFeedback() -> DomainStateFeedback<AuthState> {
        return { (state: AuthState) -> Observable<DomainEvent> in
            if case .authFailure = state {
                return Observable.just(RootState.StateEvent.logout)
            }
            guard case .authorized(let user) = state else {
                return Observable.empty()
            }
            return Observable.just(RootState.StateEvent.loggedIn(user))
        }
    }

    convenience init<DependenciesProvider: AuthUseCaseDependenciesProvider>(
        initialState: State = AuthState(),
        warehouse: DomainStoreFacade?,
        dependencyProvider: DependenciesProvider) {
        self.init(warehouse: warehouse,
                  reducer: AuthUseCase.reduce,
                  middleware: [AuthUseCase.authMiddleware(service: dependencyProvider.authService)],
                  feedbackLoop: [AuthUseCase.authFeedback()])
    }
}
