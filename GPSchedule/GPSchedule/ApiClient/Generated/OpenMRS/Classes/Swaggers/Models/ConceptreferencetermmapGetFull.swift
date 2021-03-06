//
// ConceptreferencetermmapGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptreferencetermmapGetFull: JSONEncodable {
    public var auditInfo: String?
    public var termA: ConceptreferencetermGet?
    public var termB: ConceptreferencetermGet?
    public var conceptMapType: ConceptmaptypeGet?


    public init(auditInfo: String?=nil, termA: ConceptreferencetermGet?=nil, termB: ConceptreferencetermGet?=nil, conceptMapType: ConceptmaptypeGet?=nil) {
        self.auditInfo = auditInfo
        self.termA = termA
        self.termB = termB
        self.conceptMapType = conceptMapType
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["termA"] = self.termA?.encodeToJSON()
        nillableDictionary["termB"] = self.termB?.encodeToJSON()
        nillableDictionary["conceptMapType"] = self.conceptMapType?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
