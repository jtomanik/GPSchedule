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

    public init() {}

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
