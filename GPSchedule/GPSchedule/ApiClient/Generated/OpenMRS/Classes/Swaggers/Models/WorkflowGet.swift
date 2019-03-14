//
// WorkflowGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class WorkflowGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var concept: ConceptGetRef?
    public var states: [WorkflowStateGetRef]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["concept"] = self.concept?.encodeToJSON()
        nillableDictionary["states"] = self.states?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
