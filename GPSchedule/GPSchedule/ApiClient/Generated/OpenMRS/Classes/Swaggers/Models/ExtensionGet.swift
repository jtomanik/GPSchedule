//
// ExtensionGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ExtensionGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var appId: String?
    public var extensionPointId: String?
    public var type: String?
    public var label: String?
    public var url: String?
    public var icon: String?
    public var order: Int32?
    public var requiredPrivilege: String?
    public var featureToggle: String?
    public var require: String?
    public var script: String?
    public var extensionParams: [String:String]?
    public var belongsTo: AppGetRef?


    public init(uuid: String?=nil, display: String?=nil, appId: String?=nil, extensionPointId: String?=nil, type: String?=nil, label: String?=nil, url: String?=nil, icon: String?=nil, order: Int32?=nil, requiredPrivilege: String?=nil, featureToggle: String?=nil, require: String?=nil, script: String?=nil, extensionParams: [String:String]?=nil, belongsTo: AppGetRef?=nil) {
        self.uuid = uuid
        self.display = display
        self.appId = appId
        self.extensionPointId = extensionPointId
        self.type = type
        self.label = label
        self.url = url
        self.icon = icon
        self.order = order
        self.requiredPrivilege = requiredPrivilege
        self.featureToggle = featureToggle
        self.require = require
        self.script = script
        self.extensionParams = extensionParams
        self.belongsTo = belongsTo
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["appId"] = self.appId
        nillableDictionary["extensionPointId"] = self.extensionPointId
        nillableDictionary["type"] = self.type
        nillableDictionary["label"] = self.label
        nillableDictionary["url"] = self.url
        nillableDictionary["icon"] = self.icon
        nillableDictionary["order"] = self.order?.encodeToJSON()
        nillableDictionary["requiredPrivilege"] = self.requiredPrivilege
        nillableDictionary["featureToggle"] = self.featureToggle
        nillableDictionary["require"] = self.require
        nillableDictionary["script"] = self.script
        nillableDictionary["extensionParams"] = self.extensionParams?.encodeToJSON()
        nillableDictionary["belongsTo"] = self.belongsTo?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
