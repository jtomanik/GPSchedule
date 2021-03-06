//
// CaresettingGet.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class CaresettingGet: JSONEncodable {
    public enum CareSettingType: String {
        case outpatient = "OUTPATIENT"
        case inpatient = "INPATIENT"
    }
    public var uuid: String?
    public var display: String?
        public var careSettingType: CareSettingType?


    public init(uuid: String?=nil, display: String?=nil, careSettingType: CareSettingType?=nil) {
        self.uuid = uuid
        self.display = display
        self.careSettingType = careSettingType
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["uuid"] = self.uuid
        nillableDictionary["display"] = self.display
        nillableDictionary["careSettingType"] = self.careSettingType?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
