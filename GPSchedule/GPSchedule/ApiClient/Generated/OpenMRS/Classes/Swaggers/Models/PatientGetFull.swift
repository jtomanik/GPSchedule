//
// PatientGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PatientGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var identifiers: [PatientIdentifierGetRef]?
    public var preferred: Bool?
    public var voided: Bool?
    public var person: PersonGet?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
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
