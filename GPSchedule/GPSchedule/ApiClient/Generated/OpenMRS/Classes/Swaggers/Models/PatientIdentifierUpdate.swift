//
// PatientIdentifierUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PatientIdentifierUpdate: JSONEncodable {
    public var identifier: String
    public var identifierType: String
    public var location: String?
    public var preferred: Bool?


    public init(identifier: String, identifierType: String, location: String?=nil, preferred: Bool?=nil) {
        self.identifier = identifier
        self.identifierType = identifierType
        self.location = location
        self.preferred = preferred
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["identifier"] = self.identifier
        nillableDictionary["identifierType"] = self.identifierType
        nillableDictionary["location"] = self.location
        nillableDictionary["preferred"] = self.preferred

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
