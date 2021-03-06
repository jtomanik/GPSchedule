//
// PatientIdentifierGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PatientIdentifierGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var identifier: String?
    public var preferred: Bool?
    public var voided: Bool?
    public var identifierType: PatientidentifiertypeGetRef?
    public var location: LocationGetRef?


    public init(uuid: String?=nil, display: String?=nil, identifier: String?=nil, preferred: Bool?=nil, voided: Bool?=nil, identifierType: PatientidentifiertypeGetRef?=nil, location: LocationGetRef?=nil) {
        self.uuid = uuid
        self.display = display
        self.identifier = identifier
        self.preferred = preferred
        self.voided = voided
        self.identifierType = identifierType
        self.location = location
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
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
