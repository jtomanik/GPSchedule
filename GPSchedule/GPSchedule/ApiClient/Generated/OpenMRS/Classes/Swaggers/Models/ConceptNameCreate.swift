//
// ConceptNameCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class ConceptNameCreate: JSONEncodable {
    public enum ConceptNameType: String {
        case fullySpecified = "FULLY_SPECIFIED"
        case short = "SHORT"
        case indexTerm = "INDEX_TERM"
    }
    public var name: String?
    public var locale: String?
    public var localePreferred: Bool?
        public var conceptNameType: ConceptNameType?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["locale"] = self.locale
        nillableDictionary["localePreferred"] = self.localePreferred
        nillableDictionary["conceptNameType"] = self.conceptNameType?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
