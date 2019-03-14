//
// PersonNameUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PersonNameUpdate: JSONEncodable {
    public var givenName: String?
    public var middleName: String?
    public var familyName: String?
    public var familyName2: String?
    public var preferred: Bool?
    public var _prefix: String?
    public var familyNamePrefix: String?
    public var familyNameSuffix: String?
    public var degree: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["givenName"] = self.givenName
        nillableDictionary["middleName"] = self.middleName
        nillableDictionary["familyName"] = self.familyName
        nillableDictionary["familyName2"] = self.familyName2
        nillableDictionary["preferred"] = self.preferred
        nillableDictionary["prefix"] = self._prefix
        nillableDictionary["familyNamePrefix"] = self.familyNamePrefix
        nillableDictionary["familyNameSuffix"] = self.familyNameSuffix
        nillableDictionary["degree"] = self.degree

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
