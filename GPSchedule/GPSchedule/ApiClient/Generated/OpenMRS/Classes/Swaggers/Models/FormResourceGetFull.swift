//
// FormResourceGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class FormResourceGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var valueReference: String?
    public var dataType: String?
    public var handler: String?
    public var handlerConfig: String?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, name: String?=nil, valueReference: String?=nil, dataType: String?=nil, handler: String?=nil, handlerConfig: String?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.name = name
        self.valueReference = valueReference
        self.dataType = dataType
        self.handler = handler
        self.handlerConfig = handlerConfig
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["valueReference"] = self.valueReference
        nillableDictionary["dataType"] = self.dataType
        nillableDictionary["handler"] = self.handler
        nillableDictionary["handlerConfig"] = self.handlerConfig

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
