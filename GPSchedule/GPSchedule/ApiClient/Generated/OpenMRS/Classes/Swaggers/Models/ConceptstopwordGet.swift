//
// ConceptstopwordGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptstopwordGet: JSONEncodable {
    public var uuid: String?
    public var display: String?
    public var value: String?
    public var locale: String?


    public init(uuid: String?=nil, display: String?=nil, value: String?=nil, locale: String?=nil) {
        self.uuid = uuid
        self.display = display
        self.value = value
        self.locale = locale
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["value"] = self.value
        nillableDictionary["locale"] = self.locale

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
