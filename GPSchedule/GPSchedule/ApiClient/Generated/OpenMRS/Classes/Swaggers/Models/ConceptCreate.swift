//
// ConceptCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptCreate: JSONEncodable {
    public var names: [ConceptNameCreate]
    public var datatype: String
    public var _set: Bool?
    public var version: String?
    public var answers: [String]?
    public var setMembers: [String]?
    public var hiNormal: String?
    public var hiAbsolute: String?
    public var hiCritical: String?
    public var lowNormal: String?
    public var lowAbsolute: String?
    public var lowCritical: String?
    public var units: String?
    public var allowDecimal: String?
    public var displayPrecision: String?
    public var conceptClass: String
    public var descriptions: [String]?
    public var mappings: [String]?


    public init(names: [ConceptNameCreate], datatype: String, _set: Bool?=nil, version: String?=nil, answers: [String]?=nil, setMembers: [String]?=nil, hiNormal: String?=nil, hiAbsolute: String?=nil, hiCritical: String?=nil, lowNormal: String?=nil, lowAbsolute: String?=nil, lowCritical: String?=nil, units: String?=nil, allowDecimal: String?=nil, displayPrecision: String?=nil, conceptClass: String, descriptions: [String]?=nil, mappings: [String]?=nil) {
        self.names = names
        self.datatype = datatype
        self._set = _set
        self.version = version
        self.answers = answers
        self.setMembers = setMembers
        self.hiNormal = hiNormal
        self.hiAbsolute = hiAbsolute
        self.hiCritical = hiCritical
        self.lowNormal = lowNormal
        self.lowAbsolute = lowAbsolute
        self.lowCritical = lowCritical
        self.units = units
        self.allowDecimal = allowDecimal
        self.displayPrecision = displayPrecision
        self.conceptClass = conceptClass
        self.descriptions = descriptions
        self.mappings = mappings
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["names"] = self.names.encodeToJSON()
        nillableDictionary["datatype"] = self.datatype
        nillableDictionary["set"] = self._set
        nillableDictionary["version"] = self.version
        nillableDictionary["answers"] = self.answers?.encodeToJSON()
        nillableDictionary["setMembers"] = self.setMembers?.encodeToJSON()
        nillableDictionary["hiNormal"] = self.hiNormal
        nillableDictionary["hiAbsolute"] = self.hiAbsolute
        nillableDictionary["hiCritical"] = self.hiCritical
        nillableDictionary["lowNormal"] = self.lowNormal
        nillableDictionary["lowAbsolute"] = self.lowAbsolute
        nillableDictionary["lowCritical"] = self.lowCritical
        nillableDictionary["units"] = self.units
        nillableDictionary["allowDecimal"] = self.allowDecimal
        nillableDictionary["displayPrecision"] = self.displayPrecision
        nillableDictionary["conceptClass"] = self.conceptClass
        nillableDictionary["descriptions"] = self.descriptions?.encodeToJSON()
        nillableDictionary["mappings"] = self.mappings?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
