//
// PatientGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PatientGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var identifiers: [PatientIdentifierGetRef]?
    public var preferred: Bool?
    public var voided: Bool?
    public var person: PersonGetRef?


    public init(uuid: String?=nil, display: String?=nil, identifiers: [PatientIdentifierGetRef]?=nil, preferred: Bool?=nil, voided: Bool?=nil, person: PersonGetRef?=nil) {
        self.uuid = uuid
        self.display = display
        self.identifiers = identifiers
        self.preferred = preferred
        self.voided = voided
        self.person = person
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["identifiers"] = self.identifiers?.encodeToJSON()
        nillableDictionary["preferred"] = self.preferred
        nillableDictionary["voided"] = self.voided
        nillableDictionary["person"] = self.person?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
