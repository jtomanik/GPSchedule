//
// PersonNameGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PersonNameGet: JSONEncodable {
    public var display: String?
    public var uuid: String?
    public var givenName: String?
    public var middleName: String?
    public var familyName: String?
    public var familyName2: String?
    public var voided: Bool?


    public init(display: String?=nil, uuid: String?=nil, givenName: String?=nil, middleName: String?=nil, familyName: String?=nil, familyName2: String?=nil, voided: Bool?=nil) {
        self.display = display
        self.uuid = uuid
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
        self.familyName2 = familyName2
        self.voided = voided
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["display"] = self.display
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["givenName"] = self.givenName
        nillableDictionary["middleName"] = self.middleName
        nillableDictionary["familyName"] = self.familyName
        nillableDictionary["familyName2"] = self.familyName2
        nillableDictionary["voided"] = self.voided

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
