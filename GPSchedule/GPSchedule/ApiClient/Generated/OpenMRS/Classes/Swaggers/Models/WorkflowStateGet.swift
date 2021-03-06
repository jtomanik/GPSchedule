//
// WorkflowStateGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class WorkflowStateGet: JSONEncodable {
    public var uuid: String?
    public var description: String?
    public var retired: Bool?
    public var concept: ConceptGetRef?


    public init(uuid: String?=nil, description: String?=nil, retired: Bool?=nil, concept: ConceptGetRef?=nil) {
        self.uuid = uuid
        self.description = description
        self.retired = retired
        self.concept = concept
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["description"] = self.description
        nillableDictionary["retired"] = self.retired
        nillableDictionary["concept"] = self.concept?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
