//
// RelationshipCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class RelationshipCreateFull: JSONEncodable {
    public var personA: PersonCreate
    public var relationshipType: RelationshiptypeCreate
    public var personB: PersonCreate
    public var startDate: Date?
    public var endDate: ISOFullDate?


    public init(personA: PersonCreate, relationshipType: RelationshiptypeCreate, personB: PersonCreate, startDate: Date?=nil, endDate: ISOFullDate?=nil) {
        self.personA = personA
        self.relationshipType = relationshipType
        self.personB = personB
        self.startDate = startDate
        self.endDate = endDate
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["personA"] = self.personA.encodeToJSON()
        nillableDictionary["relationshipType"] = self.relationshipType.encodeToJSON()
        nillableDictionary["personB"] = self.personB.encodeToJSON()
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
