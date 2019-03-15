//
//  Sourcery.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 12/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS

protocol Sourcery {}
protocol BasicViewGenerator: Sourcery {}

protocol DomainImportable: Sourcery {
    var uuid: String? { get }
}
protocol DomainMapable: Sourcery {}

extension String: DomainMapable {}
extension Double: DomainMapable {}
extension Bool: DomainMapable {}

extension UserGet: DomainMapable {}
extension AppointmentschedulingAppointmentGet: DomainMapable {}
extension AppointmentschedulingTimeslotGetRef: DomainMapable {}
extension AppointmentschedulingAppointmentblockGetRef: DomainMapable {}
extension AppointmentschedulingAppointmenttypeGet: DomainMapable {}
extension PatientGetRef: DomainMapable {}
extension ProviderGetRef: DomainMapable {}
extension LocationGetRef: DomainMapable {}
extension PersonGetRef: DomainMapable {}

extension ISOFullDate: DomainMapable {}

extension ISOFullDate: Equatable {
    public static func == (lhs: ISOFullDate, rhs: ISOFullDate) -> Bool {
        return lhs.description == rhs.description
    }
}

// sourcery: target = "User"
extension UserGet: DomainImportable {}

// sourcery: target = "Appointment"
extension AppointmentschedulingAppointmentGet: DomainImportable {}

// sourcery: target = "Timeslot"
extension AppointmentschedulingTimeslotGetRef: DomainImportable {}

// sourcery: target = "AppointmentBlock"
extension AppointmentschedulingAppointmentblockGetRef: DomainImportable {}

// sourcery: target = "AppointmentType"
extension AppointmentschedulingAppointmenttypeGet: DomainImportable {}

// sourcery: target = "Patient"
extension PatientGetRef: DomainImportable {}

// sourcery: target = "Staff"
extension ProviderGetRef: DomainImportable {}

// sourcery: target = "Location"
extension LocationGetRef: DomainImportable {}

// sourcery: target = "Person"
extension PersonGetRef: DomainImportable {}
