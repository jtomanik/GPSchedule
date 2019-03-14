//
// ProviderattributetypeGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ProviderattributetypeGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var minOccurs: Int32?
    public var maxOccurs: Int32?
    public var datatypeClassname: String?
    public var preferredHandlerClassname: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["minOccurs"] = self.minOccurs?.encodeToJSON()
        nillableDictionary["maxOccurs"] = self.maxOccurs?.encodeToJSON()
        nillableDictionary["datatypeClassname"] = self.datatypeClassname
        nillableDictionary["preferredHandlerClassname"] = self.preferredHandlerClassname

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}