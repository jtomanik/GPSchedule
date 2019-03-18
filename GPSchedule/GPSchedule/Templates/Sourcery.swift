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
extension Int: DomainMapable {}

extension UserGet: DomainMapable {}
extension AppointmentschedulingAppointmentGet: DomainMapable {}
extension AppointmentschedulingTimeslotGetRef: DomainMapable {}
extension AppointmentschedulingAppointmentblockGetRef: DomainMapable {}
extension AppointmentschedulingAppointmenttypeGetRef: DomainMapable {}
extension PatientGetRef: DomainMapable {}
extension ProviderGetRef: DomainMapable {}
extension LocationGetRef: DomainMapable {}
extension PersonGetRef: DomainMapable {}

extension ISOFullDate: DomainMapable {}

// sourcery: target = "User"
extension UserGet: DomainImportable {}

// sourcery: target = "Appointment"
extension AppointmentschedulingAppointmentGet: DomainImportable {}

// sourcery: target = "Timeslot"
extension AppointmentschedulingTimeslotGetRef: DomainImportable {}

// sourcery: target = "AppointmentBlock"
extension AppointmentschedulingAppointmentblockGetRef: DomainImportable {}

// sourcery: target = "AppointmentType"
extension AppointmentschedulingAppointmenttypeGetRef: DomainImportable {}

// sourcery: target = "Patient"
extension PatientGetRef: DomainImportable {}

// sourcery: target = "Staff"
extension ProviderGetRef: DomainImportable {}

// sourcery: target = "Location"
extension LocationGetRef: DomainImportable {}

// sourcery: target = "Person"
extension PersonGetRef: DomainImportable {}

// sourcery: target = "FullDate"
extension ISOFullDate: DomainImportable {
    var uuid: String? {
        return self.description
    }
}
