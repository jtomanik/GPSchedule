//
// AppointmentschedulingAppointmenttypeCreateFull.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class AppointmentschedulingAppointmenttypeCreateFull: JSONEncodable {
    public var name: String
    public var description: String?


    public init(name: String, description: String?=nil) {
        self.name = name
        self.description = description
    }
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["description"] = self.description

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
