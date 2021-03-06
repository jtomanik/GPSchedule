//
// ModuleGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ModuleGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var description: String?
    public var started: Bool?
    public var startupErrorMessage: String?
    public var packageName: String?
    public var author: String?
    public var version: String?
    public var requireOpenmrsVersion: String?
    public var awareOfModules: [String]?
    public var requiredModules: [String]?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, name: String?=nil, description: String?=nil, started: Bool?=nil, startupErrorMessage: String?=nil, packageName: String?=nil, author: String?=nil, version: String?=nil, requireOpenmrsVersion: String?=nil, awareOfModules: [String]?=nil, requiredModules: [String]?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.name = name
        self.description = description
        self.started = started
        self.startupErrorMessage = startupErrorMessage
        self.packageName = packageName
        self.author = author
        self.version = version
        self.requireOpenmrsVersion = requireOpenmrsVersion
        self.awareOfModules = awareOfModules
        self.requiredModules = requiredModules
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["started"] = self.started
        nillableDictionary["startupErrorMessage"] = self.startupErrorMessage
        nillableDictionary["packageName"] = self.packageName
        nillableDictionary["author"] = self.author
        nillableDictionary["version"] = self.version
        nillableDictionary["requireOpenmrsVersion"] = self.requireOpenmrsVersion
        nillableDictionary["awareOfModules"] = self.awareOfModules?.encodeToJSON()
        nillableDictionary["requiredModules"] = self.requiredModules?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
