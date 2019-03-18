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

protocol PatientService: ServiceCommand {
    static func patient(with id: String) -> Self
    func execute() -> Single<Patient>
}

protocol TimeslotService: ServiceCommand {
    static func timeslot(with id: String) -> Self
    func execute() -> Single<Timeslot>
}

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
    associatedtype Service3: PatientService
    associatedtype Service4: TimeslotService

    var appointmentService: Service1.Type { get }
    var appointmentsService: Service2.Type { get }
    var patientService: Service3.Type { get }
    var timeslotService: Service4.Type { get }
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
        case fetchDetail(of: Appointment, for: User)
        case fetchedFull(Appointment, for: User)

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

    static func appointmentsDetailsMiddleware<Services: CalendarUseCaseDependenciesProvider>(services: Services) -> DomainStateMiddleware<CalendarState> {
        return { (event: CalendarState.StateEvent) -> Observable<CalendarState.StateEvent> in
            guard case .fetchDetail(let appointment, let user) = event,
                let appointmentUuid = appointment.uuid,
                let patientUuid = appointment.patient?.uuid,
                let timeslotUuid = appointment.timeSlot?.uuid else {
                    return Observable.just(event)
            }
            let fullAppointment = services.appointmentService.appointment(with: appointmentUuid).execute()
            let fullPatient = services.patientService.patient(with: patientUuid).execute()
            let fullTimeslot = services.timeslotService.timeslot(with: timeslotUuid).execute()

            return Observable
                .zip(fullAppointment.asObservable(), fullPatient.asObservable(), fullTimeslot.asObservable())
                .map { (value) -> Appointment in
                    let (appointment, patient, timeslot) = value
                    appointment.patient = patient
                    appointment.timeSlot = timeslot
                    return appointment
                }
                .map { return CalendarState.StateEvent.fetchedFull($0, for: user) }
        }
    }

    static func reduce(_ state: CalendarState, _ event: CalendarState.StateEvent) -> CalendarState {
        switch event {
        case .fetchAll(let user):
            return state
        case .fetched(let items, let user):
            return .all(entires: items, user: user)
        case .fetchedFull(let appointment, let user):
            return .detail(entry: appointment, user: user)
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
