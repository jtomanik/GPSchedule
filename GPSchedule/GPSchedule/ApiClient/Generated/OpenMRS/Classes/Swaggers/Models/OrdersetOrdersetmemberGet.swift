//
// OrdersetOrdersetmemberGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class OrdersetOrdersetmemberGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var retired: Bool?
    public var orderTemplate: String?
    public var orderTemplateType: String?
    public var orderType: OrdertypeGetRef?
    public var concept: ConceptGetRef?


    public init(uuid: String?=nil, display: String?=nil, retired: Bool?=nil, orderTemplate: String?=nil, orderTemplateType: String?=nil, orderType: OrdertypeGetRef?=nil, concept: ConceptGetRef?=nil) {
        self.uuid = uuid
        self.display = display
        self.retired = retired
        self.orderTemplate = orderTemplate
        self.orderTemplateType = orderTemplateType
        self.orderType = orderType
        self.concept = concept
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["retired"] = self.retired
        nillableDictionary["orderTemplate"] = self.orderTemplate
        nillableDictionary["orderTemplateType"] = self.orderTemplateType
        nillableDictionary["orderType"] = self.orderType?.encodeToJSON()
        nillableDictionary["concept"] = self.concept?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
