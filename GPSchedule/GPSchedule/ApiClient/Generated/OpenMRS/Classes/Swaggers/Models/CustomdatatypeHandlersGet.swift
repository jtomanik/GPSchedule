//
// CustomdatatypeHandlersGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class CustomdatatypeHandlersGet: JSONEncodable {
    public var uuid: String?
    public var handlerClassname: String?
    public var display: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["handlerClassname"] = self.handlerClassname
        nillableDictionary["display"] = self.display

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
