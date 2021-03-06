//
// ProgramenrollmentGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ProgramenrollmentGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var dateEnrolled: ISOFullDate?
    public var dateCompleted: ISOFullDate?
    public var voided: Bool?
    public var patient: PatientGet?
    public var program: ProgramGet?
    public var location: LocationGet?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, dateEnrolled: ISOFullDate?=nil, dateCompleted: ISOFullDate?=nil, voided: Bool?=nil, patient: PatientGet?=nil, program: ProgramGet?=nil, location: LocationGet?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.dateEnrolled = dateEnrolled
        self.dateCompleted = dateCompleted
        self.voided = voided
        self.patient = patient
        self.program = program
        self.location = location
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["dateEnrolled"] = self.dateEnrolled?.encodeToJSON()
        nillableDictionary["dateCompleted"] = self.dateCompleted?.encodeToJSON()
        nillableDictionary["voided"] = self.voided
        nillableDictionary["patient"] = self.patient?.encodeToJSON()
        nillableDictionary["program"] = self.program?.encodeToJSON()
        nillableDictionary["location"] = self.location?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
