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
indirect enum CalendarState: DomainState {

    enum StateError: DomainError, Equatable {
        case unknown
        case api(APIError)
        case authError
    }

    enum StateEvent: DomainEvent, Equatable {
        case fetchAll(for: User)
        case fetched(entries: [Appointment], for: User)
        case fetchDetail(id: String, for: User)
        case fetchedFull(Appointment, for: User)
        case error(StateError)
        case recoverFromError
        case refresh
    }

    case all(entires: [Appointment], user: User)
    case detail(entry: Appointment, user: User)
    case error(StateError, from: CalendarState)

    init() {
        self = .all(entires: [], user: User(uuid: ""))
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
                .asObservable()
                .map { values in return CalendarState.StateEvent.fetched(entries: values, for: user)
                }
                .catchError { (error) -> Observable<CalendarState.StateEvent> in
                    guard let error = error as? APIError else {
                        return Observable.just(CalendarState.StateEvent.error(.unknown))
                    }
                    return Observable.just(CalendarState.StateEvent.error(.api(error)))
                }
        }
    }

    static func appointmentsDetailsMiddleware<Services: CalendarUseCaseDependenciesProvider>(services: Services) -> DomainStateMiddleware<CalendarState> {
        return { (event: CalendarState.StateEvent) -> Observable<CalendarState.StateEvent> in
            guard case .fetchDetail(let id, let user) = event else {
                    return Observable.just(event)
            }

            let fullAppointment = services.appointmentService.appointment(with: id)
            let fullPatientService = services.patientService
            let fullTimeslotService = services.timeslotService

            let appointmentStream = fullAppointment
                .execute()
                .asObservable()
                .share()

            let patientStream = appointmentStream
                .map { $0.patient }
                .filterNil()
                .map { $0.uuid }
                .filterNil()
                .flatMap { fullPatientService.patient(with: $0).execute().asObservable() }

            let timeslotStream = appointmentStream
                .map { $0.timeSlot }
                .filterNil()
                .map { $0.uuid }
                .filterNil()
                .flatMap { fullTimeslotService.timeslot(with: $0).execute().asObservable() }

            return Observable
                .zip(appointmentStream, patientStream, timeslotStream)
                .map { (value) -> Appointment in
                    let (appointment, patient, timeslot) = value
                    appointment.patient = patient
                    appointment.timeSlot = timeslot
                    return appointment
                }
                .map { return CalendarState.StateEvent.fetchedFull($0, for: user) }
                .asObservable()
                .catchError { (error) -> Observable<CalendarState.StateEvent> in
                    guard let error = error as? APIError else {
                        return Observable.just(CalendarState.StateEvent.error(.unknown))
                    }
                    return Observable.just(CalendarState.StateEvent.error(.api(error)))
                }
        }
    }

    static func reduce(_ state: CalendarState, _ event: CalendarState.StateEvent) -> CalendarState {
        switch (state, event) {
        case (_, .fetched(let items, let user)):
            return .all(entires: items, user: user)
        case (_, .fetchedFull(let appointment, let user)):
            return .detail(entry: appointment, user: user)
        case (_, .error(let error)):
            return .error(error, from: state)
        case (.error(_, let oldState), .recoverFromError):
            return oldState
        case (let oldState, .refresh):
            return oldState
        default:
            return state
        }
    }

    static func feedback(state: CalendarState) -> Observable<DomainEvent> {
        if case CalendarState.error(let error) = state {
            return Observable.just(RootState.StateEvent.error(RootState.StateError.genericError))
        } else {
            return Observable.empty()
        }
    }

    convenience init<DependenciesProvider: CalendarUseCaseDependenciesProvider>(
        initialState: State = CalendarState(),
        warehouse: DomainStoreFacade?,
        dependencyProvider: DependenciesProvider) {
        self.init(warehouse: warehouse,
                  reducer: CalendarUseCase.reduce,
                  middleware: [CalendarUseCase.appointmentsMiddleware(service: dependencyProvider.appointmentsService),
                               CalendarUseCase.appointmentsDetailsMiddleware(services: dependencyProvider)],
                  feedbackLoop: [CalendarUseCase.feedback])
    }
}
