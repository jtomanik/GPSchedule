//
// VisitUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class VisitUpdate: JSONEncodable {
    public var visitType: VisittypeCreate?
    public var startDatetime: ISOFullDate?
    public var location: LocationCreate?
    public var indication: ConceptCreate?
    public var stopDatetime: ISOFullDate?
    public var encounters: [EncounterCreate]?
    public var attributes: [String]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["visitType"] = self.visitType?.encodeToJSON()
        nillableDictionary["startDatetime"] = self.startDatetime?.encodeToJSON()
        nillableDictionary["location"] = self.location?.encodeToJSON()
        nillableDictionary["indication"] = self.indication?.encodeToJSON()
        nillableDictionary["stopDatetime"] = self.stopDatetime?.encodeToJSON()
        nillableDictionary["encounters"] = self.encounters?.encodeToJSON()
        nillableDictionary["attributes"] = self.attributes?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}