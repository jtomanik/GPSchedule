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

    enum StateError: DomainError, Equatable {
        case unknown
        case authError
    }

    enum StateEvent: DomainEvent, Equatable {
        case fetchAll(for: User)
        case fetched(entries: [Appointment], for: User)
        case fetchDetail(id: String)

    }

    case all(entires: [Appointment], user: User)
    case detail(entry: Appointment, user: User)
    case error(StateError)

    init() {
        self = .error(StateError.unknown)
    }
}

// sourcery: defaultState = "CalendarState"
class CalendarUseCase: GenericUseCase<CalendarState> {

    static func appointmentsMiddleware<Service: AppointmentsService>(service: Service.Type) -> DomainStateMiddleware<CalendarState> {
        return { (event: CalendarState.StateEvent) -> Observable<CalendarState.StateEvent> in
            guard case .fetchAll(let user) = event,
                let uuid = user.person?.uuid else {
                return Observable.just(event)
            }
            return service.appointments(for: uuid)
                .execute()
                .map { values in
                    return CalendarState.StateEvent.fetched(entries: values, for: user)
                }.asObservable()
        }
    }

//    static func authFeedback() -> DomainStateFeedback<AuthState> {
//        return { (state: AuthState) -> Observable<DomainEvent> in
//            return Observable.empty()
//        }
//    }

    static func reduce(_ state: CalendarState, _ event: CalendarState.StateEvent) -> CalendarState {
        switch event {
        case .fetchAll(let user):
            return state
        case .fetched(let items, let user):
            return .all(entires: items, user: user)
        default:
            return state
        }
    }

    static func errorHandler(_ state: CalendarState, _ error: Error) -> DomainEvent {
        return RootState.StateEvent.error(RootState.StateError.genericError)
    }

    convenience init<DependenciesProvider: CalendarUseCaseDependenciesProvider>(
        initialState: State = CalendarState(),
        warehouse: DomainStoreFacade?,
        dependencyProvider: DependenciesProvider) {
        self.init(warehouse: warehouse,
                  reducer: CalendarUseCase.reduce,
                  errorHandler: CalendarUseCase.errorHandler,
                  middleware: [CalendarUseCase.appointmentsMiddleware(service: dependencyProvider.appointmentsService)],
                  feedbackLoop: [])
    }
}
