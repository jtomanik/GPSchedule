//
// EncounterEncounterproviderUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class EncounterEncounterproviderUpdate: JSONEncodable {
    public var encounterRole: String?
    public var voided: Bool?
    public var voidReason: String?


    public init(encounterRole: String?=nil, voided: Bool?=nil, voidReason: String?=nil) {
        self.encounterRole = encounterRole
        self.voided = voided
        self.voidReason = voidReason
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["encounterRole"] = self.encounterRole
        nillableDictionary["voided"] = self.voided
        nillableDictionary["voidReason"] = self.voidReason

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
