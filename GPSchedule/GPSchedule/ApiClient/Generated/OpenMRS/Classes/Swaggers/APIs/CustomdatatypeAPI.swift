//
// CustomdatatypeAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class CustomdatatypeAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteCustomDatatype(uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteCustomDatatypeWithRequestBuilder(uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /customdatatype/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteCustomDatatypeWithRequestBuilder(uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/customdatatype/{uuid}"
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
     Fetch all non-retired handlers subresources
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllCustomDatatypeHandlers(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: Any?, _ error: ErrorResponse?) -> Void)) {
        getAllCustomDatatypeHandlersWithRequestBuilder(parentUuid: parentUuid, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired handlers subresources
     - GET /customdatatype/{parent-uuid}/handlers
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<Any> 
     */
    open class func getAllCustomDatatypeHandlersWithRequestBuilder(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<Any> {
        var path = "/customdatatype/{parent-uuid}/handlers"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "limit": limit,
                        "startIndex": startIndex,
                        "v": v
        ])

        let requestBuilder: RequestBuilder<Any>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch all non-retired customdatatype resources or perform search
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllCustomDatatypes(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, completion: @escaping ((_ data: FetchAll?, _ error: ErrorResponse?) -> Void)) {
        getAllCustomDatatypesWithRequestBuilder(limit: limit, startIndex: startIndex, v: v, q: q).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired customdatatype resources or perform search
     - GET /customdatatype
     - All search parameters are optional
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - returns: RequestBuilder<FetchAll> 
     */
    open class func getAllCustomDatatypesWithRequestBuilder(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil) -> RequestBuilder<FetchAll> {
        let path = "/customdatatype"
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
    open class func getCustomDatatype(uuid: String, v: String? = nil, completion: @escaping ((_ data: CustomdatatypeGet?, _ error: ErrorResponse?) -> Void)) {
        getCustomDatatypeWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /customdatatype/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<CustomdatatypeGet> 
     */
    open class func getCustomDatatypeWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<CustomdatatypeGet> {
        var path = "/customdatatype/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<CustomdatatypeGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
