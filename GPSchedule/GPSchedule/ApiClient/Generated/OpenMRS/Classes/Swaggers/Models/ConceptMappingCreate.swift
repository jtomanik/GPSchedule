//
// ConceptMappingCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptMappingCreate: JSONEncodable {
    public var conceptReferenceTerm: ConceptreferencetermCreate?
    public var conceptMapType: ConceptmaptypeCreate?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["conceptReferenceTerm"] = self.conceptReferenceTerm?.encodeToJSON()
        nillableDictionary["conceptMapType"] = self.conceptMapType?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
