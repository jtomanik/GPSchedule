//
// EncounterEncounterproviderGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class EncounterEncounterproviderGet: JSONEncodable {
    public var uuid: String?
    public var provider: ProviderGetRef?
    public var encounterRole: EncounterroleGetRef?
    public var voided: Bool?


    public init(uuid: String?=nil, provider: ProviderGetRef?=nil, encounterRole: EncounterroleGetRef?=nil, voided: Bool?=nil) {
        self.uuid = uuid
        self.provider = provider
        self.encounterRole = encounterRole
        self.voided = voided
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["provider"] = self.provider?.encodeToJSON()
        nillableDictionary["encounterRole"] = self.encounterRole?.encodeToJSON()
        nillableDictionary["voided"] = self.voided

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
