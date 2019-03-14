//
// ProgramenrollmentStateGetRef.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ProgramenrollmentStateGetRef: JSONEncodable {
    public var uuid: String?
    public var startDate: ISOFullDate?
    public var endDate: ISOFullDate?
    public var voided: Bool?
    public var state: WorkflowStateGetRef?
    public var patientProgram: Any?


    public init(uuid: String?=nil, startDate: ISOFullDate?=nil, endDate: ISOFullDate?=nil, voided: Bool?=nil, state: WorkflowStateGetRef?=nil, patientProgram: Any?=nil) {
        self.uuid = uuid
        self.startDate = startDate
        self.endDate = endDate
        self.voided = voided
        self.state = state
        self.patientProgram = patientProgram
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()
        nillableDictionary["voided"] = self.voided
        nillableDictionary["state"] = self.state?.encodeToJSON()
        nillableDictionary["patientProgram"] = self.patientProgram

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
