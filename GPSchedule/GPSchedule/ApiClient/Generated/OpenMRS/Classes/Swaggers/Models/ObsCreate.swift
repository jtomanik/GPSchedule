//
// ObsCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ObsCreate: JSONEncodable {
    public enum Status: String {
        case preliminary = "PRELIMINARY"
        case _final = "FINAL"
        case amended = "AMENDED"
    }
    public enum Interpretation: String {
        case normal = "NORMAL"
        case abnormal = "ABNORMAL"
        case criticallyAbnormal = "CRITICALLY_ABNORMAL"
        case negative = "NEGATIVE"
        case positive = "POSITIVE"
        case criticallyLow = "CRITICALLY_LOW"
        case low = "LOW"
        case high = "HIGH"
        case criticallyHigh = "CRITICALLY_HIGH"
        case verySusceptible = "VERY_SUSCEPTIBLE"
        case susceptible = "SUSCEPTIBLE"
        case intermediate = "INTERMEDIATE"
        case resistant = "RESISTANT"
        case significantChangeDown = "SIGNIFICANT_CHANGE_DOWN"
        case significantChangeUp = "SIGNIFICANT_CHANGE_UP"
        case offScaleLow = "OFF_SCALE_LOW"
        case offScaleHigh = "OFF_SCALE_HIGH"
    }
    public var person: String
    public var obsDatetime: Date
    public var concept: String
    public var location: String?
    public var order: String?
    public var encounter: String?
    public var accessionNumber: String?
    public var groupMembers: [String]?
    public var valueCodedName: String?
    public var comment: String?
    public var voided: Bool?
    public var value: String?
    public var valueModifier: String?
    public var formFieldPath: String?
    public var formFieldNamespace: String?
        public var status: Status?
        public var interpretation: Interpretation?


    public init(person: String, obsDatetime: Date, concept: String, location: String?=nil, order: String?=nil, encounter: String?=nil, accessionNumber: String?=nil, groupMembers: [String]?=nil, valueCodedName: String?=nil, comment: String?=nil, voided: Bool?=nil, value: String?=nil, valueModifier: String?=nil, formFieldPath: String?=nil, formFieldNamespace: String?=nil, status: Status?=nil, interpretation: Interpretation?=nil) {
        self.person = person
        self.obsDatetime = obsDatetime
        self.concept = concept
        self.location = location
        self.order = order
        self.encounter = encounter
        self.accessionNumber = accessionNumber
        self.groupMembers = groupMembers
        self.valueCodedName = valueCodedName
        self.comment = comment
        self.voided = voided
        self.value = value
        self.valueModifier = valueModifier
        self.formFieldPath = formFieldPath
        self.formFieldNamespace = formFieldNamespace
        self.status = status
        self.interpretation = interpretation
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["person"] = self.person
        nillableDictionary["obsDatetime"] = self.obsDatetime.encodeToJSON()
        nillableDictionary["concept"] = self.concept
        nillableDictionary["location"] = self.location
        nillableDictionary["order"] = self.order
        nillableDictionary["encounter"] = self.encounter
        nillableDictionary["accessionNumber"] = self.accessionNumber
        nillableDictionary["groupMembers"] = self.groupMembers?.encodeToJSON()
        nillableDictionary["valueCodedName"] = self.valueCodedName
        nillableDictionary["comment"] = self.comment
        nillableDictionary["voided"] = self.voided
        nillableDictionary["value"] = self.value
        nillableDictionary["valueModifier"] = self.valueModifier
        nillableDictionary["formFieldPath"] = self.formFieldPath
        nillableDictionary["formFieldNamespace"] = self.formFieldNamespace
        nillableDictionary["status"] = self.status?.rawValue
        nillableDictionary["interpretation"] = self.interpretation?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
