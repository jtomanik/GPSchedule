//
// ChartSearchPreferenceAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ChartSearchPreferenceAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteChartSearchPreference(uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteChartSearchPreferenceWithRequestBuilder(uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /chartSearchPreference/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteChartSearchPreferenceWithRequestBuilder(uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/chartSearchPreference/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "purge": purge
        ])

        let requestBuilder: RequestBuilder<Void>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch by uuid
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getChartSearchPreference(uuid: String, v: String? = nil, completion: @escaping ((_ data: ChartSearchPreferenceGet?, _ error: ErrorResponse?) -> Void)) {
        getChartSearchPreferenceWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /chartSearchPreference/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ChartSearchPreferenceGet> 
     */
    open class func getChartSearchPreferenceWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<ChartSearchPreferenceGet> {
        var path = "/chartSearchPreference/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ChartSearchPreferenceGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
