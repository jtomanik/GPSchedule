//
// PersonattributetypeUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PersonattributetypeUpdate: JSONEncodable {
    public var name: String?
    public var description: String?
    public var format: String?
    public var foreignKey: Int32?
    public var sortWeight: Double?
    public var searchable: Bool?
    public var editPrivilege: PrivilegeCreate?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["format"] = self.format
        nillableDictionary["foreignKey"] = self.foreignKey?.encodeToJSON()
        nillableDictionary["sortWeight"] = self.sortWeight
        nillableDictionary["searchable"] = self.searchable
        nillableDictionary["editPrivilege"] = self.editPrivilege?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
