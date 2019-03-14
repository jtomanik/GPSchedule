//
// EncounterEncounterproviderCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class EncounterEncounterproviderCreate: JSONEncodable {
    public var provider: String?
    public var encounterRole: String?
    public var encounter: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["provider"] = self.provider
        nillableDictionary["encounterRole"] = self.encounterRole
        nillableDictionary["encounter"] = self.encounter

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}