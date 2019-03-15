//
// OrdertypeGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class OrdertypeGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var description: String?
    public var retired: Bool?
    public var javaClassName: String?
    public var conceptClasses: [ConceptclassGet]?
    public var parent: OrdertypeGet?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, name: String?=nil, description: String?=nil, retired: Bool?=nil, javaClassName: String?=nil, conceptClasses: [ConceptclassGet]?=nil, parent: OrdertypeGet?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.name = name
        self.description = description
        self.retired = retired
        self.javaClassName = javaClassName
        self.conceptClasses = conceptClasses
        self.parent = parent
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description
        nillableDictionary["retired"] = self.retired
        nillableDictionary["javaClassName"] = self.javaClassName
        nillableDictionary["conceptClasses"] = self.conceptClasses?.encodeToJSON()
        nillableDictionary["parent"] = self.parent?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
