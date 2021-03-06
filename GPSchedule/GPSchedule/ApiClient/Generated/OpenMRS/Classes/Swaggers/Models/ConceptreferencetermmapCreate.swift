//
// ConceptreferencetermmapCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptreferencetermmapCreate: JSONEncodable {
    public var termA: ConceptreferencetermCreate
    public var termB: ConceptreferencetermCreate
    public var conceptMapType: ConceptmaptypeCreate


    public init(termA: ConceptreferencetermCreate, termB: ConceptreferencetermCreate, conceptMapType: ConceptmaptypeCreate) {
        self.termA = termA
        self.termB = termB
        self.conceptMapType = conceptMapType
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["termA"] = self.termA.encodeToJSON()
        nillableDictionary["termB"] = self.termB.encodeToJSON()
        nillableDictionary["conceptMapType"] = self.conceptMapType.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
