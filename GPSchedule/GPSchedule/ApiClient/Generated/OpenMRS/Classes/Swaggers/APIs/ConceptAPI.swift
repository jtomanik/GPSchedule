//
// ConceptAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ConceptAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteConceptAttribute(parentUuid: String, uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteConceptAttributeWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /concept/{parent-uuid}/attribute/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteConceptAttributeWithRequestBuilder(parentUuid: String, uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/concept/{parent-uuid}/attribute/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
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
     Delete or purge resource by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteConceptDescription(parentUuid: String, uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteConceptDescriptionWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /concept/{parent-uuid}/description/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteConceptDescriptionWithRequestBuilder(parentUuid: String, uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/concept/{parent-uuid}/description/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
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
     Delete or purge resource by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteConceptMap(parentUuid: String, uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteConceptMapWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /concept/{parent-uuid}/mapping/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteConceptMapWithRequestBuilder(parentUuid: String, uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/concept/{parent-uuid}/mapping/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
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
     Delete or purge resource by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteConceptName(parentUuid: String, uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deleteConceptNameWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /concept/{parent-uuid}/name/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deleteConceptNameWithRequestBuilder(parentUuid: String, uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/concept/{parent-uuid}/name/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
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
     Fetch all non-retired attribute subresources
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllConceptAttributes(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: Any?, _ error: ErrorResponse?) -> Void)) {
        getAllConceptAttributesWithRequestBuilder(parentUuid: parentUuid, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired attribute subresources
     - GET /concept/{parent-uuid}/attribute
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<Any> 
     */
    open class func getAllConceptAttributesWithRequestBuilder(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<Any> {
        var path = "/concept/{parent-uuid}/attribute"
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
     Fetch all non-retired description subresources
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllConceptDescriptions(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: Any?, _ error: ErrorResponse?) -> Void)) {
        getAllConceptDescriptionsWithRequestBuilder(parentUuid: parentUuid, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired description subresources
     - GET /concept/{parent-uuid}/description
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<Any> 
     */
    open class func getAllConceptDescriptionsWithRequestBuilder(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<Any> {
        var path = "/concept/{parent-uuid}/description"
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
     Fetch all non-retired mapping subresources
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllConceptMaps(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: Any?, _ error: ErrorResponse?) -> Void)) {
        getAllConceptMapsWithRequestBuilder(parentUuid: parentUuid, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired mapping subresources
     - GET /concept/{parent-uuid}/mapping
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<Any> 
     */
    open class func getAllConceptMapsWithRequestBuilder(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<Any> {
        var path = "/concept/{parent-uuid}/mapping"
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
     Fetch all non-retired name subresources
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllConceptNames(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: Any?, _ error: ErrorResponse?) -> Void)) {
        getAllConceptNamesWithRequestBuilder(parentUuid: parentUuid, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired name subresources
     - GET /concept/{parent-uuid}/name
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<Any> 
     */
    open class func getAllConceptNamesWithRequestBuilder(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<Any> {
        var path = "/concept/{parent-uuid}/name"
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
     Fetch all non-retired concept resources or perform search
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter code: (query) Must be used with source (optional)
     - parameter searchType: (query) Must be used with name (optional)
     - parameter name: (query)  (optional)
     - parameter term: (query)  (optional)
     - parameter source: (query)  (optional)
     - parameter _class: (query) Must be used with name (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllConcepts(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, code: String? = nil, searchType: String? = nil, name: String? = nil, term: String? = nil, source: String? = nil, _class: String? = nil, completion: @escaping ((_ data: FetchAll?, _ error: ErrorResponse?) -> Void)) {
        getAllConceptsWithRequestBuilder(limit: limit, startIndex: startIndex, v: v, q: q, code: code, searchType: searchType, name: name, term: term, source: source, _class: _class).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired concept resources or perform search
     - GET /concept
     - All search parameters are optional
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter code: (query) Must be used with source (optional)
     - parameter searchType: (query) Must be used with name (optional)
     - parameter name: (query)  (optional)
     - parameter term: (query)  (optional)
     - parameter source: (query)  (optional)
     - parameter _class: (query) Must be used with name (optional)
     - returns: RequestBuilder<FetchAll> 
     */
    open class func getAllConceptsWithRequestBuilder(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, code: String? = nil, searchType: String? = nil, name: String? = nil, term: String? = nil, source: String? = nil, _class: String? = nil) -> RequestBuilder<FetchAll> {
        let path = "/concept"
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "limit": limit,
                        "startIndex": startIndex,
                        "v": v,
                        "q": q,
                        "code": code,
                        "searchType": searchType,
                        "name": name,
                        "term": term,
                        "source": source,
                        "class": _class
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
    open class func getConcept(uuid: String, v: String? = nil, completion: @escaping ((_ data: ConceptGet?, _ error: ErrorResponse?) -> Void)) {
        getConceptWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /concept/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ConceptGet> 
     */
    open class func getConceptWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<ConceptGet> {
        var path = "/concept/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ConceptGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch attribute subresources by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getConceptAttribute(parentUuid: String, uuid: String, v: String? = nil, completion: @escaping ((_ data: ConceptAttributeGet?, _ error: ErrorResponse?) -> Void)) {
        getConceptAttributeWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch attribute subresources by uuid
     - GET /concept/{parent-uuid}/attribute/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ConceptAttributeGet> 
     */
    open class func getConceptAttributeWithRequestBuilder(parentUuid: String, uuid: String, v: String? = nil) -> RequestBuilder<ConceptAttributeGet> {
        var path = "/concept/{parent-uuid}/attribute/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ConceptAttributeGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch description subresources by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getConceptDescription(parentUuid: String, uuid: String, v: String? = nil, completion: @escaping ((_ data: ConceptDescriptionGet?, _ error: ErrorResponse?) -> Void)) {
        getConceptDescriptionWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch description subresources by uuid
     - GET /concept/{parent-uuid}/description/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ConceptDescriptionGet> 
     */
    open class func getConceptDescriptionWithRequestBuilder(parentUuid: String, uuid: String, v: String? = nil) -> RequestBuilder<ConceptDescriptionGet> {
        var path = "/concept/{parent-uuid}/description/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ConceptDescriptionGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch mapping subresources by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getConceptMap(parentUuid: String, uuid: String, v: String? = nil, completion: @escaping ((_ data: ConceptMappingGet?, _ error: ErrorResponse?) -> Void)) {
        getConceptMapWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch mapping subresources by uuid
     - GET /concept/{parent-uuid}/mapping/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ConceptMappingGet> 
     */
    open class func getConceptMapWithRequestBuilder(parentUuid: String, uuid: String, v: String? = nil) -> RequestBuilder<ConceptMappingGet> {
        var path = "/concept/{parent-uuid}/mapping/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ConceptMappingGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch name subresources by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getConceptName(parentUuid: String, uuid: String, v: String? = nil, completion: @escaping ((_ data: ConceptNameGet?, _ error: ErrorResponse?) -> Void)) {
        getConceptNameWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch name subresources by uuid
     - GET /concept/{parent-uuid}/name/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<ConceptNameGet> 
     */
    open class func getConceptNameWithRequestBuilder(parentUuid: String, uuid: String, v: String? = nil) -> RequestBuilder<ConceptNameGet> {
        var path = "/concept/{parent-uuid}/name/{uuid}"
        let parentUuidPreEscape = "\(parentUuid)"
        let parentUuidPostEscape = parentUuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{parent-uuid}", with: parentUuidPostEscape, options: .literal, range: nil)
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<ConceptNameGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
