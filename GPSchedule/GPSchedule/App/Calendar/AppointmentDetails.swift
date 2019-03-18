//
//  AppointmentService.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 15/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS
import RxSwift
import RxOptional

struct AppointmentDetails: AppointmentService {

    static func appointment(with id: String) -> AppointmentDetails {
        return AppointmentDetails(uuid: id)
    }

    private let uuid: String

    private init(uuid: String) {
        self.uuid = uuid
    }

    func execute() -> Single<Appointment> {
        return AppointmentschedulingAppointmentAPI
            .getAppointmentWithRequestBuilder(uuid: uuid, v: "full")
            .addCredential()
            .rx()
            .filterNil()
            .asSingle()
    }
}
