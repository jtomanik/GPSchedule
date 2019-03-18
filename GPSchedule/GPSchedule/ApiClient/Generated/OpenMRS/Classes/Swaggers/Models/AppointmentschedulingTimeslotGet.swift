//
// AppointmentschedulingTimeslotGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class AppointmentschedulingTimeslotGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var startDate: ISOFullDate?
    public var endDate: ISOFullDate?
    public var appointmentBlock: AppointmentschedulingAppointmentblockGet?
    public var countOfAppointments: Double?
    public var unallocatedMinutes: Double?
    public var voided: Bool?


    public init(uuid: String?=nil, display: String?=nil, startDate: ISOFullDate?=nil, endDate: ISOFullDate?=nil, appointmentBlock: AppointmentschedulingAppointmentblockGet?=nil, countOfAppointments: Double?=nil, unallocatedMinutes: Double?=nil, voided: Bool?=nil) {
        self.uuid = uuid
        self.display = display
        self.startDate = startDate
        self.endDate = endDate
        self.appointmentBlock = appointmentBlock
        self.countOfAppointments = countOfAppointments
        self.unallocatedMinutes = unallocatedMinutes
        self.voided = voided
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()
        nillableDictionary["appointmentBlock"] = self.appointmentBlock?.encodeToJSON()
        nillableDictionary["countOfAppointments"] = self.countOfAppointments
        nillableDictionary["unallocatedMinutes"] = self.unallocatedMinutes
        nillableDictionary["voided"] = self.voided

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
