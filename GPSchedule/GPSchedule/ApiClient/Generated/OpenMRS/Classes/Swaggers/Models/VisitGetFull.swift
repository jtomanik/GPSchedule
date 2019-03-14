//
// VisitGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class VisitGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var startDatetime: ISOFullDate?
    public var stopDatetime: ISOFullDate?
    public var attributes: [String]?
    public var voided: Bool?
    public var patient: PatientGet?
    public var visitType: VisittypeGet?
    public var indication: ConceptGet?
    public var location: LocationGet?
    public var encounters: [EncounterGet]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
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
