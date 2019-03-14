//
// LocationCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class LocationCreateFull: JSONEncodable {
    public var name: String?
    public var description: String?
    public var address1: String?
    public var address2: String?
    public var cityVillage: String?
    public var stateProvince: String?
    public var country: String?
    public var postalCode: String?
    public var latitude: String?
    public var longitude: String?
    public var countyDistrict: String?
    public var address3: String?
    public var address4: String?
    public var address5: String?
    public var address6: String?
    public var tags: [String]?
    public var parentLocation: String?
    public var childLocations: [String]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["address1"] = self.address1
        nillableDictionary["address2"] = self.address2
        nillableDictionary["cityVillage"] = self.cityVillage
        nillableDictionary["stateProvince"] = self.stateProvince
        nillableDictionary["country"] = self.country
        nillableDictionary["postalCode"] = self.postalCode
        nillableDictionary["latitude"] = self.latitude
        nillableDictionary["longitude"] = self.longitude
        nillableDictionary["countyDistrict"] = self.countyDistrict
        nillableDictionary["address3"] = self.address3
        nillableDictionary["address4"] = self.address4
        nillableDictionary["address5"] = self.address5
        nillableDictionary["address6"] = self.address6
        nillableDictionary["tags"] = self.tags?.encodeToJSON()
        nillableDictionary["parentLocation"] = self.parentLocation
        nillableDictionary["childLocations"] = self.childLocations?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
