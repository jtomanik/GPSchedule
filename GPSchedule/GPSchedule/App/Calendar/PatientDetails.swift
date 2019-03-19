//
//  PatientDetails.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 18/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS
import RxSwift
import RxOptional

struct PatientDetails: PatientService {

    static func patient(with id: String) -> PatientDetails {
        return PatientDetails(uuid: id)
    }

    private let uuid: String

    private init(uuid: String) {
        self.uuid = uuid
    }

    func execute() -> Single<Patient> {
        return PatientAPI
            .getPatientWithRequestBuilder(uuid: uuid, v: "full")
            .addCredential()
            .rx()
            .filterNil()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
