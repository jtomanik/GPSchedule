//
// ConceptattributetypeGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptattributetypeGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var description: String?
    public var retired: Bool?
    public var minOccurs: Int32?
    public var maxOccurs: Int32?
    public var datatypeClassname: String?
    public var preferredHandlerClassname: String?
    public var datatypeConfig: String?
    public var handlerConfig: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["retired"] = self.retired
        nillableDictionary["minOccurs"] = self.minOccurs?.encodeToJSON()
        nillableDictionary["maxOccurs"] = self.maxOccurs?.encodeToJSON()
        nillableDictionary["datatypeClassname"] = self.datatypeClassname
        nillableDictionary["preferredHandlerClassname"] = self.preferredHandlerClassname
        nillableDictionary["datatypeConfig"] = self.datatypeConfig
        nillableDictionary["handlerConfig"] = self.handlerConfig

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
