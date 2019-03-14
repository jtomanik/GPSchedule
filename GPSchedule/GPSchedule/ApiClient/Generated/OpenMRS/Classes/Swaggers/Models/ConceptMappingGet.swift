//
// ConceptMappingGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptMappingGet: JSONEncodable {
    public var display: String?
    public var uuid: String?
    public var conceptReferenceTerm: ConceptreferencetermGetRef?
    public var conceptMapType: ConceptmaptypeGetRef?


    public init(display: String?=nil, uuid: String?=nil, conceptReferenceTerm: ConceptreferencetermGetRef?=nil, conceptMapType: ConceptmaptypeGetRef?=nil) {
        self.display = display
        self.uuid = uuid
        self.conceptReferenceTerm = conceptReferenceTerm
        self.conceptMapType = conceptMapType
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["display"] = self.display
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["conceptReferenceTerm"] = self.conceptReferenceTerm?.encodeToJSON()
        nillableDictionary["conceptMapType"] = self.conceptMapType?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
