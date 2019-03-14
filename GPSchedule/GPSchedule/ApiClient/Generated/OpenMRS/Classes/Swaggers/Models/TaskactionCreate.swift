//
// TaskactionCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class TaskactionCreate: JSONEncodable {
    public enum Action: String {
        case scheduletask = "SCHEDULETASK"
        case shutdowntask = "SHUTDOWNTASK"
        case rescheduletask = "RESCHEDULETASK"
        case reschedulealltasks = "RESCHEDULEALLTASKS"
        case delete = "DELETE"
    }
    public var tasks: [String]?
    public var allTasks: Bool?
        public var action: Action


    public init(tasks: [String]?=nil, allTasks: Bool?=nil, action: Action) {
        self.tasks = tasks
        self.allTasks = allTasks
        self.action = action
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["tasks"] = self.tasks?.encodeToJSON()
        nillableDictionary["allTasks"] = self.allTasks
        nillableDictionary["action"] = self.action.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
