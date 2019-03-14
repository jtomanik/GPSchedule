//
// ModuleGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ModuleGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var description: String?
    public var started: Bool?
    public var startupErrorMessage: String?


    public init(uuid: String?=nil, display: String?=nil, name: String?=nil, description: String?=nil, started: Bool?=nil, startupErrorMessage: String?=nil) {
        self.uuid = uuid
        self.display = display
        self.name = name
        self.description = description
        self.started = started
        self.startupErrorMessage = startupErrorMessage
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["started"] = self.started
        nillableDictionary["startupErrorMessage"] = self.startupErrorMessage

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
