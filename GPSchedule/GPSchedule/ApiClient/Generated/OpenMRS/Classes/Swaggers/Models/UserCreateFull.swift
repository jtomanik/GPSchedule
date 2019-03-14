//
// UserCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class UserCreateFull: JSONEncodable {
    public var name: String
    public var description: String?
    public var username: String
    public var password: String
    public var person: PersonCreate
    public var systemId: String?
    public var userProperties: Any?
    public var roles: [RoleCreate]?
    public var proficientLocales: [Any]?
    public var secretQuestion: String?


    public init(name: String, description: String?=nil, username: String, password: String, person: PersonCreate, systemId: String?=nil, userProperties: Any?=nil, roles: [RoleCreate]?=nil, proficientLocales: [Any]?=nil, secretQuestion: String?=nil) {
        self.name = name
        self.description = description
        self.username = username
        self.password = password
        self.person = person
        self.systemId = systemId
        self.userProperties = userProperties
        self.roles = roles
        self.proficientLocales = proficientLocales
        self.secretQuestion = secretQuestion
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["username"] = self.username
        nillableDictionary["password"] = self.password
        nillableDictionary["person"] = self.person.encodeToJSON()
        nillableDictionary["systemId"] = self.systemId
        nillableDictionary["userProperties"] = self.userProperties
        nillableDictionary["roles"] = self.roles?.encodeToJSON()
        nillableDictionary["proficientLocales"] = self.proficientLocales?.encodeToJSON()
        nillableDictionary["secretQuestion"] = self.secretQuestion

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
