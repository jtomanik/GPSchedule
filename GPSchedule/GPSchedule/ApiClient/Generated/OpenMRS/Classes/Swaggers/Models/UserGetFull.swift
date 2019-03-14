//
// UserGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class UserGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var description: String?
    public var retired: Bool?
    public var username: String?
    public var systemId: String?
    public var userProperties: Any?
    public var person: PersonGet?
    public var privileges: [PrivilegeGet]?
    public var roles: [RoleGet]?
    public var allRoles: [RoleGet]?
    public var proficientLocales: [Any]?
    public var secretQuestion: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["retired"] = self.retired
        nillableDictionary["username"] = self.username
        nillableDictionary["systemId"] = self.systemId
        nillableDictionary["userProperties"] = self.userProperties
        nillableDictionary["person"] = self.person?.encodeToJSON()
        nillableDictionary["privileges"] = self.privileges?.encodeToJSON()
        nillableDictionary["roles"] = self.roles?.encodeToJSON()
        nillableDictionary["allRoles"] = self.allRoles?.encodeToJSON()
        nillableDictionary["proficientLocales"] = self.proficientLocales?.encodeToJSON()
        nillableDictionary["secretQuestion"] = self.secretQuestion

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
