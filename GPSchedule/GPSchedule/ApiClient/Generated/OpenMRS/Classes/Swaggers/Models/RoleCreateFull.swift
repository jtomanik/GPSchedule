//
// RoleCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class RoleCreateFull: JSONEncodable {
    public var name: String
    public var description: String?
    public var privileges: [PrivilegeCreate]?
    public var inheritedRoles: [RoleCreate]?


    public init(name: String, description: String?=nil, privileges: [PrivilegeCreate]?=nil, inheritedRoles: [RoleCreate]?=nil) {
        self.name = name
        self.description = description
        self.privileges = privileges
        self.inheritedRoles = inheritedRoles
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["privileges"] = self.privileges?.encodeToJSON()
        nillableDictionary["inheritedRoles"] = self.inheritedRoles?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
