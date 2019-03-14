//
// PersonAttributeCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PersonAttributeCreateFull: JSONEncodable {
    public var attributeType: PersonattributetypeCreate?
    public var value: String?
    public var hydratedObject: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["attributeType"] = self.attributeType?.encodeToJSON()
        nillableDictionary["value"] = self.value
        nillableDictionary["hydratedObject"] = self.hydratedObject

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
