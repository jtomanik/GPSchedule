//
// OrderAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class OrderAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteOrder(uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteOrderWithRequestBuilder(uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /order/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteOrderWithRequestBuilder(uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/order/{uuid}"
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
     Search for order
     - parameter q: (query) The search query 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllOrders(q: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: FetchAll?, _ error: ErrorResponse?) -> Void)) {
        getAllOrdersWithRequestBuilder(q: q, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Search for order
     - GET /order
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
    open class func getAllOrdersWithRequestBuilder(q: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<FetchAll> {
        let path = "/order"
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
    open class func getOrder(uuid: String, v: String? = nil, completion: @escaping ((_ data: OrderGet?, _ error: ErrorResponse?) -> Void)) {
        getOrderWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /order/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<OrderGet> 
     */
    open class func getOrderWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<OrderGet> {
        var path = "/order/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<OrderGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}