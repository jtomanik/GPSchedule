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
extension AppointmentschedulingTimeslotGet: DomainMapable {}
extension AppointmentschedulingTimeslotGetRef: DomainMapable {}
extension AppointmentschedulingAppointmentblockGet: DomainMapable {}
extension AppointmentschedulingAppointmentblockGetRef: DomainMapable {}
extension AppointmentschedulingAppointmenttypeGet: DomainMapable {}
extension AppointmentschedulingAppointmenttypeGetRef: DomainMapable {}
extension PatientGet: DomainMapable {}
extension PatientGetRef: DomainMapable {}
extension ProviderGet: DomainMapable {}
extension ProviderGetRef: DomainMapable {}
extension ProviderGetFull: DomainMapable {}
extension LocationGet: DomainMapable {}
extension LocationGetRef: DomainMapable {}
extension PersonGet: DomainMapable {}
extension PersonGetRef: DomainMapable {}
extension PersonGetFull: DomainMapable {}

extension ISOFullDate: DomainMapable {}

// sourcery: target = "User"
extension UserGet: DomainImportable {}

// sourcery: target = "Appointment"
extension AppointmentschedulingAppointmentGet: DomainImportable {}

// sourcery: target = "Timeslot"
extension AppointmentschedulingTimeslotGetRef: DomainImportable {}
// sourcery: target = "TimeslotShort"
extension AppointmentschedulingTimeslotGet: DomainImportable {}

// sourcery: target = "AppointmentBlock"
extension AppointmentschedulingAppointmentblockGet: DomainImportable {}
// sourcery: target = "AppointmentBlockShort"
extension AppointmentschedulingAppointmentblockGetRef: DomainImportable {}

// sourcery: target = "AppointmentType"
extension AppointmentschedulingAppointmenttypeGet: DomainImportable {}
// sourcery: target = "AppointmentTypeShort"
extension AppointmentschedulingAppointmenttypeGetRef: DomainImportable {}

// sourcery: target = "Patient"
extension PatientGet: DomainImportable {}
// sourcery: target = "PatientShort"
extension PatientGetRef: DomainImportable {}

// sourcery: target = "Staff"
extension ProviderGet: DomainImportable {}
// sourcery: target = "StaffShort"
extension ProviderGetRef: DomainImportable {}

// sourcery: target = "Location"
extension LocationGet: DomainImportable {}
// sourcery: target = "LocationShort"
extension LocationGetRef: DomainImportable {}

// sourcery: target = "Person"
extension PersonGet: DomainImportable {}
// sourcery: target = "PersonShort"
extension PersonGetRef: DomainImportable {}

// sourcery: target = "FullDate"
extension ISOFullDate: DomainImportable {
    var uuid: String? {
        return self.description
    }
}
