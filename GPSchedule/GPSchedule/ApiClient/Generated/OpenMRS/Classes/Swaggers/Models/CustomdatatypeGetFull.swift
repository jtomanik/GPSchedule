//
// CustomdatatypeGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class CustomdatatypeGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var datatypeClassname: String?
    public var handlers: [CustomdatatypeHandlersGet]?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, datatypeClassname: String?=nil, handlers: [CustomdatatypeHandlersGet]?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.datatypeClassname = datatypeClassname
        self.handlers = handlers
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["datatypeClassname"] = self.datatypeClassname
        nillableDictionary["handlers"] = self.handlers?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
