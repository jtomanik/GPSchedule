//
// FormFormfieldGetFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class FormFormfieldGetFull: JSONEncodable {
    public var auditInfo: String?
    public var uuid: String?
    public var display: String?
    public var fieldNumber: Int32?
    public var fieldPart: String?
    public var pageNumber: Int32?
    public var minOccurs: Int32?
    public var maxOccurs: Int32?
    public var _required: Bool?
    public var sortWeight: Float?
    public var retired: Bool?
    public var parent: FormFormfieldGet?
    public var form: FormGet?
    public var field: FieldGet?


    public init(auditInfo: String?=nil, uuid: String?=nil, display: String?=nil, fieldNumber: Int32?=nil, fieldPart: String?=nil, pageNumber: Int32?=nil, minOccurs: Int32?=nil, maxOccurs: Int32?=nil, _required: Bool?=nil, sortWeight: Float?=nil, retired: Bool?=nil, parent: FormFormfieldGet?=nil, form: FormGet?=nil, field: FieldGet?=nil) {
        self.auditInfo = auditInfo
        self.uuid = uuid
        self.display = display
        self.fieldNumber = fieldNumber
        self.fieldPart = fieldPart
        self.pageNumber = pageNumber
        self.minOccurs = minOccurs
        self.maxOccurs = maxOccurs
        self._required = _required
        self.sortWeight = sortWeight
        self.retired = retired
        self.parent = parent
        self.form = form
        self.field = field
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["auditInfo"] = self.auditInfo
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["fieldNumber"] = self.fieldNumber?.encodeToJSON()
        nillableDictionary["fieldPart"] = self.fieldPart
        nillableDictionary["pageNumber"] = self.pageNumber?.encodeToJSON()
        nillableDictionary["minOccurs"] = self.minOccurs?.encodeToJSON()
        nillableDictionary["maxOccurs"] = self.maxOccurs?.encodeToJSON()
        nillableDictionary["required"] = self._required
        nillableDictionary["sortWeight"] = self.sortWeight
        nillableDictionary["retired"] = self.retired
        nillableDictionary["parent"] = self.parent?.encodeToJSON()
        nillableDictionary["form"] = self.form?.encodeToJSON()
        nillableDictionary["field"] = self.field?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
