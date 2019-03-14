//
// ConceptNameGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptNameGetFull: JSONEncodable {
    public enum ConceptNameType: String {
        case fullySpecified = "FULLY_SPECIFIED"
        case short = "SHORT"
        case indexTerm = "INDEX_TERM"
    }
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var name: String?
    public var locale: String?
    public var localePreferred: Bool?
        public var conceptNameType: ConceptNameType?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, name: String?=nil, locale: String?=nil, localePreferred: Bool?=nil, conceptNameType: ConceptNameType?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.name = name
        self.locale = locale
        self.localePreferred = localePreferred
        self.conceptNameType = conceptNameType
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["name"] = self.name
        nillableDictionary["locale"] = self.locale
        nillableDictionary["localePreferred"] = self.localePreferred
        nillableDictionary["conceptNameType"] = self.conceptNameType?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
