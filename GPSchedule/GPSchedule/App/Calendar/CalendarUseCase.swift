//
//  CalendarUseCase.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 17/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

protocol AppointmentService: ServiceCommand {
    static func appointment(with id: String) -> Self
    func execute() -> Single<Appointment>
}

protocol AppointmentsService: ServiceCommand {
    static func appointments(for id: String) -> Self
    func execute() -> Single<[Appointment]>
}

protocol CalendarServiceProvider: ServiceProvider {
    associatedtype Service1: AppointmentService
    associatedtype Service2: AppointmentsService

    var appointmentService: Service1.Type { get }
    var appointmentsService: Service2.Type { get }
}

typealias CalendarUseCaseDependenciesProvider = CalendarServiceProvider

// sourcery: defaultState = "AuthState"
enum CalendarState: DomainState {

    enum StateEvent: DomainEvent, Equatable {
        case fetchAll(for: User)
        case fetchDetail(id: String)

    }

    case all(entires: [Appointment], user: User)
    case detail(entry: Appointment, user: User)
    case error(DomainError)

    init() {
        self = .error(DomainError.genericError)
    }
}

// sourcery: defaultState = "CalendarState"
class CalendarUseCase: GenericUseCase<CalendarState> {

//    static func authMiddleware<Service: AuthService>(service: Service.Type) -> DomainStateMiddleware<AuthState> {
//        return { (event: AuthState.StateEvent) -> Observable<AuthState.StateEvent> in
//            guard case .login(let username, let password) = event else {
//                return Observable.just(event)
//            }
//            return service.logIn(username: username, password: password)
//                .execute()
//                .map { AuthState.StateEvent.loggedIn($0) }
//                .catchError { (error) -> Single<AuthState.StateEvent> in
//                    guard let error = error as? AuthError else {
//                        return Single.just(AuthState.StateEvent.error(.genericError))
//                    }
//                    switch error {
//                    case .unknown:
//                        return Single.just(AuthState.StateEvent.error(.genericError))
//                    case .errorMessage(let message):
//                        return Single.just(AuthState.StateEvent.error(.errorMessage(message)))
//                    }
//                }
//                .asObservable()
//        }
//    }

    static func authFeedback() -> DomainStateFeedback<AuthState> {
        return { (state: AuthState) -> Observable<DomainEvent> in
            return Observable.empty()
        }
    }

    static func reduce(_ state: CalendarState, _ event: CalendarState.StateEvent) -> CalendarState {
        return state
    }

    convenience init<DependenciesProvider: CalendarUseCaseDependenciesProvider>(
        initialState: State = CalendarState(),
        warehouse: DomainStoreFacade?,
        dependencyProvider: DependenciesProvider) {
        self.init(warehouse: warehouse,
                  reducer: CalendarUseCase.reduce,
                  middleware: [],
                  feedbackLoop: [])
    }
}
