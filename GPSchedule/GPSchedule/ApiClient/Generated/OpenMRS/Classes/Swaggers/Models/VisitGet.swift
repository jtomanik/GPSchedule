//
// VisitGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class VisitGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var startDatetime: ISOFullDate?
    public var stopDatetime: ISOFullDate?
    public var attributes: [String]?
    public var voided: Bool?
    public var patient: PatientGetRef?
    public var visitType: VisittypeGetRef?
    public var indication: ConceptGetRef?
    public var location: LocationGetRef?
    public var encounters: [EncounterGetRef]?


    public init(uuid: String?=nil, display: String?=nil, startDatetime: ISOFullDate?=nil, stopDatetime: ISOFullDate?=nil, attributes: [String]?=nil, voided: Bool?=nil, patient: PatientGetRef?=nil, visitType: VisittypeGetRef?=nil, indication: ConceptGetRef?=nil, location: LocationGetRef?=nil, encounters: [EncounterGetRef]?=nil) {
        self.uuid = uuid
        self.display = display
        self.startDatetime = startDatetime
        self.stopDatetime = stopDatetime
        self.attributes = attributes
        self.voided = voided
        self.patient = patient
        self.visitType = visitType
        self.indication = indication
        self.location = location
        self.encounters = encounters
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["startDatetime"] = self.startDatetime?.encodeToJSON()
        nillableDictionary["stopDatetime"] = self.stopDatetime?.encodeToJSON()
        nillableDictionary["attributes"] = self.attributes?.encodeToJSON()
        nillableDictionary["voided"] = self.voided
        nillableDictionary["patient"] = self.patient?.encodeToJSON()
        nillableDictionary["visitType"] = self.visitType?.encodeToJSON()
        nillableDictionary["indication"] = self.indication?.encodeToJSON()
        nillableDictionary["location"] = self.location?.encodeToJSON()
        nillableDictionary["encounters"] = self.encounters?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
