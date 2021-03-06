//
// PatientidentifiertypeGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class PatientidentifiertypeGetFull: JSONEncodable {
    public enum LocationBehavior: String {
        case _required = "REQUIRED"
        case notUsed = "NOT_USED"
    }
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var description: String?
    public var retired: Bool?
    public var format: String?
    public var formatDescription: String?
    public var _required: Bool?
    public var checkDigit: Bool?
    public var validator: String?
        public var locationBehavior: LocationBehavior?
    public var uniquenessBehavior: String?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, name: String?=nil, description: String?=nil, retired: Bool?=nil, format: String?=nil, formatDescription: String?=nil, _required: Bool?=nil, checkDigit: Bool?=nil, validator: String?=nil, locationBehavior: LocationBehavior?=nil, uniquenessBehavior: String?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.name = name
        self.description = description
        self.retired = retired
        self.format = format
        self.formatDescription = formatDescription
        self._required = _required
        self.checkDigit = checkDigit
        self.validator = validator
        self.locationBehavior = locationBehavior
        self.uniquenessBehavior = uniquenessBehavior
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["retired"] = self.retired
        nillableDictionary["format"] = self.format
        nillableDictionary["formatDescription"] = self.formatDescription
        nillableDictionary["required"] = self._required
        nillableDictionary["checkDigit"] = self.checkDigit
        nillableDictionary["validator"] = self.validator
        nillableDictionary["locationBehavior"] = self.locationBehavior?.rawValue
        nillableDictionary["uniquenessBehavior"] = self.uniquenessBehavior

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
