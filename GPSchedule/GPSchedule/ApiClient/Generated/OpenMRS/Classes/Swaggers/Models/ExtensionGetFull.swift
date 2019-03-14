//
// ExtensionGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ExtensionGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
