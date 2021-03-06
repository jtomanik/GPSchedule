//
// CohortMembershipCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class CohortMembershipCreateFull: JSONEncodable {
    public var patientUuid: String?
    public var startDate: Date?
    public var endDate: ISOFullDate?


    public init(patientUuid: String?=nil, startDate: Date?=nil, endDate: ISOFullDate?=nil) {
        self.patientUuid = patientUuid
        self.startDate = startDate
        self.endDate = endDate
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["patientUuid"] = self.patientUuid
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
