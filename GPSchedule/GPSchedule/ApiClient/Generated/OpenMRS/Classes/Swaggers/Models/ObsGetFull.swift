//
// ObsGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ObsGetFull: JSONEncodable {
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
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var obsDatetime: ISOFullDate?
    public var accessionNumber: String?
    public var comment: String?
    public var voided: Bool?
    public var value: String?
    public var valueModifier: String?
    public var concept: ConceptGet?
    public var person: PersonGet?
    public var obsGroup: ObsGet?
    public var groupMembers: [ObsGet]?
    public var valueCodedName: ConceptNameGet?
    public var location: LocationGet?
    public var order: OrderGet?
    public var encounter: EncounterGet?
    public var formFieldPath: String?
    public var formFieldNamespace: String?
        public var status: Status?
        public var interpretation: Interpretation?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, obsDatetime: ISOFullDate?=nil, accessionNumber: String?=nil, comment: String?=nil, voided: Bool?=nil, value: String?=nil, valueModifier: String?=nil, concept: ConceptGet?=nil, person: PersonGet?=nil, obsGroup: ObsGet?=nil, groupMembers: [ObsGet]?=nil, valueCodedName: ConceptNameGet?=nil, location: LocationGet?=nil, order: OrderGet?=nil, encounter: EncounterGet?=nil, formFieldPath: String?=nil, formFieldNamespace: String?=nil, status: Status?=nil, interpretation: Interpretation?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.obsDatetime = obsDatetime
        self.accessionNumber = accessionNumber
        self.comment = comment
        self.voided = voided
        self.value = value
        self.valueModifier = valueModifier
        self.concept = concept
        self.person = person
        self.obsGroup = obsGroup
        self.groupMembers = groupMembers
        self.valueCodedName = valueCodedName
        self.location = location
        self.order = order
        self.encounter = encounter
        self.formFieldPath = formFieldPath
        self.formFieldNamespace = formFieldNamespace
        self.status = status
        self.interpretation = interpretation
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["obsDatetime"] = self.obsDatetime?.encodeToJSON()
        nillableDictionary["accessionNumber"] = self.accessionNumber
        nillableDictionary["comment"] = self.comment
        nillableDictionary["voided"] = self.voided
        nillableDictionary["value"] = self.value
        nillableDictionary["valueModifier"] = self.valueModifier
        nillableDictionary["concept"] = self.concept?.encodeToJSON()
        nillableDictionary["person"] = self.person?.encodeToJSON()
        nillableDictionary["obsGroup"] = self.obsGroup?.encodeToJSON()
        nillableDictionary["groupMembers"] = self.groupMembers?.encodeToJSON()
        nillableDictionary["valueCodedName"] = self.valueCodedName?.encodeToJSON()
        nillableDictionary["location"] = self.location?.encodeToJSON()
        nillableDictionary["order"] = self.order?.encodeToJSON()
        nillableDictionary["encounter"] = self.encounter?.encodeToJSON()
        nillableDictionary["formFieldPath"] = self.formFieldPath
        nillableDictionary["formFieldNamespace"] = self.formFieldNamespace
        nillableDictionary["status"] = self.status?.rawValue
        nillableDictionary["interpretation"] = self.interpretation?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
