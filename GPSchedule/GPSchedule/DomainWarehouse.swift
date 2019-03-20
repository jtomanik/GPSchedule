//
//  DomainWarehouse.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DomainWarehouse: DomainStoreFacade {

// sourcery:inline:auto:DomainWarehouse.Generated
// swiftlint:disable all

    let appointmentService = AppointmentDetails.self
    let authService = Authenticator.self
    let patientService = PatientDetails.self
    let appointmentsService = PersonalSchedule.self
    let timeslotService = TimeslotDetails.self

    var authUseCase: AuthUseCase!
    var calendarUseCase: CalendarUseCase!
    var rootUseCase: RootUseCase!

    private let disposeBag = DisposeBag()

    init() {
        self.authUseCase = AuthUseCase(initialState: AuthState(),warehouse: self,  dependencyProvider: self)

        self.calendarUseCase = CalendarUseCase(initialState: CalendarState(),warehouse: self,  dependencyProvider: self)

        self.rootUseCase = RootUseCase(initialState: RootState(),warehouse: self,  dependencyProvider: self)

    }

    func getStore<S>(for type: S.Type) -> S {
        switch type {
        case is AuthUseCase.Type:
            return authUseCase! as! S
        case is CalendarUseCase.Type:
            return calendarUseCase! as! S
        case is RootUseCase.Type:
            return rootUseCase! as! S
        default:
            fatalError("Store type is not a part of a Warehouse")
        }
    }

    func dispatch(event: DomainEvent) {
        switch event {
        case let event as AuthState.StateEvent:
            authUseCase.dispatch(event: event)
        case let event as CalendarState.StateEvent:
            calendarUseCase.dispatch(event: event)
        case let event as RootState.StateEvent:
            rootUseCase.dispatch(event: event)
        default:
            return
        }
    }
// swiftlint:enable all
// sourcery:end
}
