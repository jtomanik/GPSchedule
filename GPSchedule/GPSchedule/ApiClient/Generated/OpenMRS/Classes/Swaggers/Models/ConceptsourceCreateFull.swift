//
// ConceptsourceCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptsourceCreateFull: JSONEncodable {
    public var name: String
    public var description: String
    public var hl7Code: String?
    public var uniqueId: String?


    public init(name: String, description: String, hl7Code: String?=nil, uniqueId: String?=nil) {
        self.name = name
        self.description = description
        self.hl7Code = hl7Code
        self.uniqueId = uniqueId
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["hl7Code"] = self.hl7Code
        nillableDictionary["uniqueId"] = self.uniqueId

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
