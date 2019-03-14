//
// ConceptmaptypeUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptmaptypeUpdate: JSONEncodable {
    public var name: String
    public var description: String?
    public var isHidden: Bool?


    public init(name: String, description: String?=nil, isHidden: Bool?=nil) {
        self.name = name
        self.description = description
        self.isHidden = isHidden
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["isHidden"] = self.isHidden

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
