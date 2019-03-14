//
// OrdersetOrdersetmemberUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class OrdersetOrdersetmemberUpdate: JSONEncodable {
    public var orderType: Any?
    public var orderTemplate: String?
    public var concept: String?
    public var retired: Bool?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["orderType"] = self.orderType
        nillableDictionary["orderTemplate"] = self.orderTemplate
        nillableDictionary["concept"] = self.concept
        nillableDictionary["retired"] = self.retired

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}