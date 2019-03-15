//
// ProviderattributetypeGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ProviderattributetypeGetFull: JSONEncodable {
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


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, name: String?=nil, description: String?=nil, retired: Bool?=nil, minOccurs: Int32?=nil, maxOccurs: Int32?=nil, datatypeClassname: String?=nil, preferredHandlerClassname: String?=nil, datatypeConfig: String?=nil, handlerConfig: String?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.name = name
        self.description = description
        self.retired = retired
        self.minOccurs = minOccurs
        self.maxOccurs = maxOccurs
        self.datatypeClassname = datatypeClassname
        self.preferredHandlerClassname = preferredHandlerClassname
        self.datatypeConfig = datatypeConfig
        self.handlerConfig = handlerConfig
    }
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
