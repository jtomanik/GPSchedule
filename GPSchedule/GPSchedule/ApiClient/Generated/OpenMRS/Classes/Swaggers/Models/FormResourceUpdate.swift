//
// FormResourceUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class FormResourceUpdate: JSONEncodable {
    public var form: String?
    public var name: String?
    public var dataType: String?
    public var handler: String?
    public var handlerConfig: String?
    public var value: String?
    public var valueReference: String?


    public init(form: String?=nil, name: String?=nil, dataType: String?=nil, handler: String?=nil, handlerConfig: String?=nil, value: String?=nil, valueReference: String?=nil) {
        self.form = form
        self.name = name
        self.dataType = dataType
        self.handler = handler
        self.handlerConfig = handlerConfig
        self.value = value
        self.valueReference = valueReference
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["form"] = self.form
        nillableDictionary["name"] = self.name
        nillableDictionary["dataType"] = self.dataType
        nillableDictionary["handler"] = self.handler
        nillableDictionary["handlerConfig"] = self.handlerConfig
        nillableDictionary["value"] = self.value
        nillableDictionary["valueReference"] = self.valueReference

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
