//
// UserAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class UserAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteUser(uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteUserWithRequestBuilder(uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /user/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteUserWithRequestBuilder(uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/user/{uuid}"
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
     Fetch all non-retired user resources or perform search
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter username: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllUsers(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, username: String? = nil, completion: @escaping ((_ data: FetchAll?, _ error: ErrorResponse?) -> Void)) {
        getAllUsersWithRequestBuilder(limit: limit, startIndex: startIndex, v: v, q: q, username: username).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired user resources or perform search
     - GET /user
     - All search parameters are optional
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter username: (query)  (optional)
     - returns: RequestBuilder<FetchAll> 
     */
    open class func getAllUsersWithRequestBuilder(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, username: String? = nil) -> RequestBuilder<FetchAll> {
        let path = "/user"
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "limit": limit,
                        "startIndex": startIndex,
                        "v": v,
                        "q": q,
                        "username": username
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
    open class func getUser(uuid: String, v: String? = nil, completion: @escaping ((_ data: UserGet?, _ error: ErrorResponse?) -> Void)) {
        getUserWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /user/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<UserGet> 
     */
    open class func getUserWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<UserGet> {
        var path = "/user/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<UserGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
