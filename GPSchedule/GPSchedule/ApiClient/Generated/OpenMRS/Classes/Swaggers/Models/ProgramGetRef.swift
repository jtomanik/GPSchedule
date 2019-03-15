//
// ProgramGetRef.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ProgramGetRef: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var allWorkflows: [WorkflowGetRef]?


    public init(uuid: String?=nil, display: String?=nil, allWorkflows: [WorkflowGetRef]?=nil) {
        self.uuid = uuid
        self.display = display
        self.allWorkflows = allWorkflows
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["allWorkflows"] = self.allWorkflows?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
