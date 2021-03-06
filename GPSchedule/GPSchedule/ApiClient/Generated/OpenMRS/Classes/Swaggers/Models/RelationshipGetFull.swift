//
// RelationshipGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class RelationshipGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var voided: Bool?
    public var personA: PersonGet?
    public var relationshipType: RelationshiptypeGet?
    public var personB: PersonGet?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, voided: Bool?=nil, personA: PersonGet?=nil, relationshipType: RelationshiptypeGet?=nil, personB: PersonGet?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.voided = voided
        self.personA = personA
        self.relationshipType = relationshipType
        self.personB = personB
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["voided"] = self.voided
        nillableDictionary["personA"] = self.personA?.encodeToJSON()
        nillableDictionary["relationshipType"] = self.relationshipType?.encodeToJSON()
        nillableDictionary["personB"] = self.personB?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
