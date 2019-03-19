//
//  TimeslotDetails.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 18/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS
import RxSwift
import RxOptional

struct TimeslotDetails: TimeslotService {

    static func timeslot(with id: String) -> TimeslotDetails {
        return TimeslotDetails(uuid: id)
    }

    private let uuid: String

    private init(uuid: String) {
        self.uuid = uuid
    }

    func execute() -> Single<Timeslot> {
        return AppointmentschedulingTimeslotAPI
            .getTimeSlotWithRequestBuilder(uuid: uuid, v: "full")
            .addCredential()
            .rx()
            .filterNil()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
