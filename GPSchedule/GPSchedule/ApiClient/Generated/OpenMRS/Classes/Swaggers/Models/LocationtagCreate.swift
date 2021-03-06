//
// LocationtagCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class LocationtagCreate: JSONEncodable {
    public var name: String
    public var description: String?
    public var retired: Bool?
    public var retiredReason: String?


    public init(name: String, description: String?=nil, retired: Bool?=nil, retiredReason: String?=nil) {
        self.name = name
        self.description = description
        self.retired = retired
        self.retiredReason = retiredReason
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["retired"] = self.retired
        nillableDictionary["retiredReason"] = self.retiredReason

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
