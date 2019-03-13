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

struct User: DomainModel, Equatable {
    let username: String
}

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

protocol RootUseCaseDependenciesProvider: AuthServiceProvider {}

enum DomainError: Error, Equatable {
    case genericError
    case errorMessage(String)
}

enum RootState: DomainState {

    enum DomainEvent: Event, Equatable {
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

class RootUseCase: GenericUseCase<RootState> {

    static func authMiddleware<Service: AuthService>(service: Service.Type) -> DomainStateMiddleware<RootState> {
        return { (event: RootState.DomainEvent) -> Observable<RootState.DomainEvent> in
            guard case .login(let username, let password) = event else {
                return Observable.just(event)
            }
            return service.logIn(username: username, password: password)
                .execute()
                .map { RootState.DomainEvent.loggedIn($0) }
                .catchError { (error) -> Single<RootState.DomainEvent> in
                    guard let error = error as? AuthError else {
                        return Single.just(RootState.DomainEvent.error(.genericError))
                    }
                    switch error {
                    case .unknown:
                        return Single.just(RootState.DomainEvent.error(.genericError))
                    case .errorMessage(let message):
                        return Single.just(RootState.DomainEvent.error(.errorMessage(message)))
                    }
                }
                .asObservable()
        }
    }

    static func reduce(_ state: RootState, _ event: RootState.DomainEvent) -> RootState {
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
            return state
        }
    }

    convenience init<DependenciesProvider: RootUseCaseDependenciesProvider>(
        initialState: State = RootState(),
        dependencyProvider: DependenciesProvider)  {
        self.init(initialState: initialState,
                  reducer: RootUseCase.reduce,
                  middlewares: [RootUseCase.authMiddleware(service: dependencyProvider.authService)],
                  feedbackLoops: [])
    }
}
