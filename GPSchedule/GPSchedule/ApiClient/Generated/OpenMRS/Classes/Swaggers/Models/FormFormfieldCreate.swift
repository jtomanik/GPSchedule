//
// FormFormfieldCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class FormFormfieldCreate: JSONEncodable {
    public var form: String
    public var field: String
    public var _required: Bool
    public var parent: String?
    public var fieldNumber: Int32?
    public var fieldPart: String?
    public var pageNumber: Int32?
    public var minOccurs: Int32?
    public var maxOccurs: Int32?
    public var sortWeight: Bool?


    public init(form: String, field: String, _required: Bool, parent: String?=nil, fieldNumber: Int32?=nil, fieldPart: String?=nil, pageNumber: Int32?=nil, minOccurs: Int32?=nil, maxOccurs: Int32?=nil, sortWeight: Bool?=nil) {
        self.form = form
        self.field = field
        self._required = _required
        self.parent = parent
        self.fieldNumber = fieldNumber
        self.fieldPart = fieldPart
        self.pageNumber = pageNumber
        self.minOccurs = minOccurs
        self.maxOccurs = maxOccurs
        self.sortWeight = sortWeight
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["form"] = self.form
        nillableDictionary["field"] = self.field
        nillableDictionary["required"] = self._required
        nillableDictionary["parent"] = self.parent
        nillableDictionary["fieldNumber"] = self.fieldNumber?.encodeToJSON()
        nillableDictionary["fieldPart"] = self.fieldPart
        nillableDictionary["pageNumber"] = self.pageNumber?.encodeToJSON()
        nillableDictionary["minOccurs"] = self.minOccurs?.encodeToJSON()
        nillableDictionary["maxOccurs"] = self.maxOccurs?.encodeToJSON()
        nillableDictionary["sortWeight"] = self.sortWeight

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
