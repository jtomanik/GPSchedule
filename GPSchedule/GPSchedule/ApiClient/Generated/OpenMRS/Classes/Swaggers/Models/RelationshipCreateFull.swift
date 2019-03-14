//
// RelationshipCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class RelationshipCreateFull: JSONEncodable {
    public var personA: PersonCreate?
    public var relationshipType: RelationshiptypeCreate?
    public var personB: PersonCreate?
    public var startDate: ISOFullDate?
    public var endDate: ISOFullDate?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["personA"] = self.personA?.encodeToJSON()
        nillableDictionary["relationshipType"] = self.relationshipType?.encodeToJSON()
        nillableDictionary["personB"] = self.personB?.encodeToJSON()
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
