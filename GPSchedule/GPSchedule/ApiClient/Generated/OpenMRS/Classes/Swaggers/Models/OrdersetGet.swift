//
// OrdersetGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class OrdersetGet: JSONEncodable {
    public enum Operator: String {
        case all = "ALL"
        case one = "ONE"
        case any = "ANY"
    }
    public var uuid: String?
    public var display: String?
        public var _operator: Operator?
    public var orderSetMembers: [OrdersetOrdersetmemberGetRef]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["operator"] = self._operator?.rawValue
        nillableDictionary["orderSetMembers"] = self.orderSetMembers?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
