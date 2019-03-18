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

struct PersonalSchedule: AppointmentsService {

    typealias Model = [Appointment]

    static func appointments(for id: String) -> PersonalSchedule {
        return PersonalSchedule(uuid: id)
    }

    private let uuid: String

    private init(uuid: String) {
        self.uuid = uuid
    }

    func execute() -> Single<[Appointment]> {
        return AppointmentschedulingAppointmentAPI
            .getAllAppointmentsWithRequestBuilder(v: "full")
            .addCredential()
            .rx()
            .errorOnNil(APIError.backendError)
            .map { $0.results }
            .filterNil()
            .map { Decoders.decode(clazz: Array<AppointmentschedulingAppointmentGet>.self, source: $0 as AnyObject) }
            .map { $0.value }
            .errorOnNil(APIError.parsingError) // parsing error
            .map { [uuid] in $0.filter({ $0.timeSlot?.appointmentBlock?.provider?.person?.uuid == uuid }) }
            .asSingle()
    }
}
