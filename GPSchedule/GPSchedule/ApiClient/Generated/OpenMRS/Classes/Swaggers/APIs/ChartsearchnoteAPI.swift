//
// ChartsearchnoteAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ChartsearchnoteAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteChartSearchNote(uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteChartSearchNoteWithRequestBuilder(uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /chartsearchnote/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteChartSearchNoteWithRequestBuilder(uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/chartsearchnote/{uuid}"
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
     Search for chartsearchnote
     - parameter q: (query) The search query 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllChartSearchNotes(q: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: FetchAll?, _ error: ErrorResponse?) -> Void)) {
        getAllChartSearchNotesWithRequestBuilder(q: q, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Search for chartsearchnote
     - GET /chartsearchnote
     - At least one search parameter must be specified
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter q: (query) The search query 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<FetchAll> 
     */
    open class func getAllChartSearchNotesWithRequestBuilder(q: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<FetchAll> {
        let path = "/chartsearchnote"
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "limit": limit,
                        "startIndex": startIndex,
                        "v": v,
                        "q": q
        ])

        let requestBuilder: RequestBuilder<FetchAll>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch by uuid
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getChartSearchNote(uuid: String, v: String? = nil, completion: @escaping ((_ data: ChartsearchnoteGet?, _ error: ErrorResponse?) -> Void)) {
        getChartSearchNoteWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /chartsearchnote/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ChartsearchnoteGet> 
     */
    open class func getChartSearchNoteWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<ChartsearchnoteGet> {
        var path = "/chartsearchnote/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ChartsearchnoteGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}