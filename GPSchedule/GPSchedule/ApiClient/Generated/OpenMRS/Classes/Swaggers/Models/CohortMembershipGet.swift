//
// CohortMembershipGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class CohortMembershipGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var startDate: Date?
    public var endDate: Date?
    public var patientUuid: String?


    public init(uuid: String?=nil, display: String?=nil, startDate: Date?=nil, endDate: Date?=nil, patientUuid: String?=nil) {
        self.uuid = uuid
        self.display = display
        self.startDate = startDate
        self.endDate = endDate
        self.patientUuid = patientUuid
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()
        nillableDictionary["patientUuid"] = self.patientUuid

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
