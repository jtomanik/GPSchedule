//
// PatientIdentifierGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PatientIdentifierGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var identifier: String?
    public var preferred: Bool?
    public var voided: Bool?
    public var identifierType: PatientidentifiertypeGet?
    public var location: LocationGet?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["identifier"] = self.identifier
        nillableDictionary["preferred"] = self.preferred
        nillableDictionary["voided"] = self.voided
        nillableDictionary["identifierType"] = self.identifierType?.encodeToJSON()
        nillableDictionary["location"] = self.location?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
