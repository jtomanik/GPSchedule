//
// PersonAddressGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PersonAddressGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var preferred: Bool?
    public var address1: String?
    public var address2: String?
    public var cityVillage: String?
    public var stateProvince: String?
    public var country: String?
    public var postalCode: String?
    public var countyDistrict: String?
    public var address3: String?
    public var address4: String?
    public var address5: String?
    public var address6: String?
    public var startDate: ISOFullDate?
    public var endDate: ISOFullDate?
    public var latitude: String?
    public var longitude: String?
    public var voided: Bool?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["preferred"] = self.preferred
        nillableDictionary["address1"] = self.address1
        nillableDictionary["address2"] = self.address2
        nillableDictionary["cityVillage"] = self.cityVillage
        nillableDictionary["stateProvince"] = self.stateProvince
        nillableDictionary["country"] = self.country
        nillableDictionary["postalCode"] = self.postalCode
        nillableDictionary["countyDistrict"] = self.countyDistrict
        nillableDictionary["address3"] = self.address3
        nillableDictionary["address4"] = self.address4
        nillableDictionary["address5"] = self.address5
        nillableDictionary["address6"] = self.address6
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()
        nillableDictionary["latitude"] = self.latitude
        nillableDictionary["longitude"] = self.longitude
        nillableDictionary["voided"] = self.voided

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
