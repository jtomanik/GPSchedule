//
// ConceptUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptUpdate: JSONEncodable {
    public var name: ConceptNameCreate?
    public var names: [ConceptNameCreate]?
    public var descriptions: [ConceptDescriptionCreate]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name?.encodeToJSON()
        nillableDictionary["names"] = self.names?.encodeToJSON()
        nillableDictionary["descriptions"] = self.descriptions?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
