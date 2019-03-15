//
// PersonCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PersonCreateFull: JSONEncodable {
    public enum Gender: String {
        case m = "M"
        case f = "F"
    }
    public var names: [PersonNameCreate]
        public var gender: Gender
    public var age: Int32?
    public var birthdate: ISOFullDate?
    public var birthdateEstimated: Bool?
    public var dead: Bool?
    public var deathDate: ISOFullDate?
    public var causeOfDeath: String?
    public var addresses: [PersonAddressCreate]?
    public var attributes: [PersonAttributeCreate]?
    public var deathdateEstimated: Bool?
    public var birthtime: Date?


    public init(names: [PersonNameCreate], gender: Gender, age: Int32?=nil, birthdate: ISOFullDate?=nil, birthdateEstimated: Bool?=nil, dead: Bool?=nil, deathDate: ISOFullDate?=nil, causeOfDeath: String?=nil, addresses: [PersonAddressCreate]?=nil, attributes: [PersonAttributeCreate]?=nil, deathdateEstimated: Bool?=nil, birthtime: Date?=nil) {
        self.names = names
        self.gender = gender
        self.age = age
        self.birthdate = birthdate
        self.birthdateEstimated = birthdateEstimated
        self.dead = dead
        self.deathDate = deathDate
        self.causeOfDeath = causeOfDeath
        self.addresses = addresses
        self.attributes = attributes
        self.deathdateEstimated = deathdateEstimated
        self.birthtime = birthtime
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["names"] = self.names.encodeToJSON()
        nillableDictionary["gender"] = self.gender.rawValue
        nillableDictionary["age"] = self.age?.encodeToJSON()
        nillableDictionary["birthdate"] = self.birthdate?.encodeToJSON()
        nillableDictionary["birthdateEstimated"] = self.birthdateEstimated
        nillableDictionary["dead"] = self.dead
        nillableDictionary["deathDate"] = self.deathDate?.encodeToJSON()
        nillableDictionary["causeOfDeath"] = self.causeOfDeath
        nillableDictionary["addresses"] = self.addresses?.encodeToJSON()
        nillableDictionary["attributes"] = self.attributes?.encodeToJSON()
        nillableDictionary["deathdateEstimated"] = self.deathdateEstimated
        nillableDictionary["birthtime"] = self.birthtime?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
