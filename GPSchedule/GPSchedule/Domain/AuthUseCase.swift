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

enum AuthError: Error {
    case unknown
    case errorMessage(String)
}

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

    enum StateEvent: DomainEvent, Equatable {
        case login(username: String, password: String)
        case loggedIn(User)
        case logout
        case lock
        case unlock
        case error(DomainError)
    }

    case unauthorized(error: String?)
    case authorized(user: User)
    //        case locked(user: User)
    case error(DomainError)

    init() {
        self = .unauthorized(error: nil)
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
                    guard let error = error as? AuthError else {
                        return Single.just(AuthState.StateEvent.error(.genericError))
                    }
                    switch error {
                    case .unknown:
                        return Single.just(AuthState.StateEvent.error(.genericError))
                    case .errorMessage(let message):
                        return Single.just(AuthState.StateEvent.error(.errorMessage(message)))
                    }
                }
                .asObservable()
        }
    }

    static func authFeedback() -> DomainStateFeedback<AuthState> {
        return { (state: AuthState) -> Observable<DomainEvent> in
            if case .error(let error) = state {
                return Observable.just(RootState.StateEvent.error(error))
            }
            guard case .authorized(let user) = state else {
                return Observable.empty()
            }
            return Observable.just(RootState.StateEvent.loggedIn(user))
        }
    }

    static func reduce(_ state: AuthState, _ event: AuthState.StateEvent) -> AuthState {
        switch event {
        case .login:
            return state
        case .loggedIn(let user):
            return .authorized(user: user)
        case .logout:
            return .unauthorized(error: nil)
        case .lock:
            return state
        case .unlock:
            return state
        case .error:
            return .error(DomainError.genericError)
        }
    }

    convenience init<DependenciesProvider: AuthUseCaseDependenciesProvider>(
        initialState: State = AuthState(),
        warehouse: DomainStoreFacade?,
        dependencyProvider: DependenciesProvider) {
        self.init(initialState: initialState,
                  warehouse: warehouse,
                  reducer: AuthUseCase.reduce,
                  middleware: [AuthUseCase.authMiddleware(service: dependencyProvider.authService)],
                  feedbackLoop: [AuthUseCase.authFeedback()])
    }
}

