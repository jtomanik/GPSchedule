//
//  DomainWarehouse.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

class DomainWarehouse: DomainStoreFacade {

// sourcery:inline:auto:DomainWarehouse.Generated
// swiftlint:disable all
    let appointmentService = AppointmentDetail.self
    let authService = Authenticator.self
    let appointmentsService = PersonalSchedule.self

    var rootUseCase: RootUseCase!

    init() {
        self.rootUseCase = RootUseCase(initialState: RootState(), dependencyProvider: self)

    }

    func dispatch(event: Event) {
        switch event {
        case let event as RootState.DomainEvent:
            rootUseCase.dispatch(event: event)
        default:
            return
        }
    }
// swiftlint:enable all
// sourcery:end
}
