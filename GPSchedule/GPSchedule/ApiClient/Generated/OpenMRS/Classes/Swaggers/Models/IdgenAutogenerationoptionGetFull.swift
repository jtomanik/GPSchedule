//
// IdgenAutogenerationoptionGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class IdgenAutogenerationoptionGetFull: JSONEncodable {
    public var auditInfo: String?


    public init(auditInfo: String?=nil) {
        self.auditInfo = auditInfo
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
