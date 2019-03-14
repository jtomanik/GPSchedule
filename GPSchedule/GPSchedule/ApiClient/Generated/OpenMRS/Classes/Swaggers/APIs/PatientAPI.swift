//
// PatientAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class PatientAPI: APIBase {
    /**
     Delete or purge resource by uuid
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deletePatient(uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deletePatientWithRequestBuilder(uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /patient/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deletePatientWithRequestBuilder(uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/patient/{uuid}"
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
    open class func deletePatientAllergy(parentUuid: String, uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deletePatientAllergyWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /patient/{parent-uuid}/allergy/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deletePatientAllergyWithRequestBuilder(parentUuid: String, uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/patient/{parent-uuid}/allergy/{uuid}"
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
    open class func deletePatientIdentifier(parentUuid: String, uuid: String, purge: Bool? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        deletePatientIdentifierWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, purge: purge).execute { (response, error) -> Void in
            completion(error)
        }
    }


    /**
     Delete or purge resource by uuid
     - DELETE /patient/{parent-uuid}/identifier/{uuid}
     - The resource will be voided/retired unless purge = 'true'
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to delete 
     - parameter purge: (query)  (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func deletePatientIdentifierWithRequestBuilder(parentUuid: String, uuid: String, purge: Bool? = nil) -> RequestBuilder<Void> {
        var path = "/patient/{parent-uuid}/identifier/{uuid}"
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
     Fetch all non-retired identifier subresources
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllPatientIdentifiers(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, completion: @escaping ((_ data: Any?, _ error: ErrorResponse?) -> Void)) {
        getAllPatientIdentifiersWithRequestBuilder(parentUuid: parentUuid, limit: limit, startIndex: startIndex, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch all non-retired identifier subresources
     - GET /patient/{parent-uuid}/identifier
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<Any> 
     */
    open class func getAllPatientIdentifiersWithRequestBuilder(parentUuid: String, limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil) -> RequestBuilder<Any> {
        var path = "/patient/{parent-uuid}/identifier"
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
     Search for patient
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter matchSimilar: (query)  (optional)
     - parameter country: (query) Must be used with matchSimilar (optional)
     - parameter identifier: (query)  (optional)
     - parameter birthdate: (query) Must be used with matchSimilar (optional)
     - parameter gender: (query) Must be used with matchSimilar (optional)
     - parameter city: (query) Must be used with matchSimilar (optional)
     - parameter address2: (query) Must be used with matchSimilar (optional)
     - parameter searchType: (query) Must be used with identifier (optional)
     - parameter address1: (query) Must be used with matchSimilar (optional)
     - parameter familyname: (query) Must be used with matchSimilar (optional)
     - parameter middlename: (query) Must be used with matchSimilar (optional)
     - parameter lastviewed: (query)  (optional)
     - parameter postalcode: (query) Must be used with matchSimilar (optional)
     - parameter givenname: (query) Must be used with matchSimilar (optional)
     - parameter state: (query) Must be used with matchSimilar (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllPatients(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, matchSimilar: String? = nil, country: String? = nil, identifier: String? = nil, birthdate: String? = nil, gender: String? = nil, city: String? = nil, address2: String? = nil, searchType: String? = nil, address1: String? = nil, familyname: String? = nil, middlename: String? = nil, lastviewed: String? = nil, postalcode: String? = nil, givenname: String? = nil, state: String? = nil, completion: @escaping ((_ data: FetchAll?, _ error: ErrorResponse?) -> Void)) {
        getAllPatientsWithRequestBuilder(limit: limit, startIndex: startIndex, v: v, q: q, matchSimilar: matchSimilar, country: country, identifier: identifier, birthdate: birthdate, gender: gender, city: city, address2: address2, searchType: searchType, address1: address1, familyname: familyname, middlename: middlename, lastviewed: lastviewed, postalcode: postalcode, givenname: givenname, state: state).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Search for patient
     - GET /patient
     - At least one search parameter must be specified
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter limit: (query) The number of results to return (optional)
     - parameter startIndex: (query) The offset at which to start (optional)
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter q: (query) The search query (optional)
     - parameter matchSimilar: (query)  (optional)
     - parameter country: (query) Must be used with matchSimilar (optional)
     - parameter identifier: (query)  (optional)
     - parameter birthdate: (query) Must be used with matchSimilar (optional)
     - parameter gender: (query) Must be used with matchSimilar (optional)
     - parameter city: (query) Must be used with matchSimilar (optional)
     - parameter address2: (query) Must be used with matchSimilar (optional)
     - parameter searchType: (query) Must be used with identifier (optional)
     - parameter address1: (query) Must be used with matchSimilar (optional)
     - parameter familyname: (query) Must be used with matchSimilar (optional)
     - parameter middlename: (query) Must be used with matchSimilar (optional)
     - parameter lastviewed: (query)  (optional)
     - parameter postalcode: (query) Must be used with matchSimilar (optional)
     - parameter givenname: (query) Must be used with matchSimilar (optional)
     - parameter state: (query) Must be used with matchSimilar (optional)
     - returns: RequestBuilder<FetchAll> 
     */
    open class func getAllPatientsWithRequestBuilder(limit: Int32? = nil, startIndex: Int32? = nil, v: String? = nil, q: String? = nil, matchSimilar: String? = nil, country: String? = nil, identifier: String? = nil, birthdate: String? = nil, gender: String? = nil, city: String? = nil, address2: String? = nil, searchType: String? = nil, address1: String? = nil, familyname: String? = nil, middlename: String? = nil, lastviewed: String? = nil, postalcode: String? = nil, givenname: String? = nil, state: String? = nil) -> RequestBuilder<FetchAll> {
        let path = "/patient"
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "limit": limit,
                        "startIndex": startIndex,
                        "v": v,
                        "q": q,
                        "matchSimilar": matchSimilar,
                        "country": country,
                        "identifier": identifier,
                        "birthdate": birthdate,
                        "gender": gender,
                        "city": city,
                        "address2": address2,
                        "searchType": searchType,
                        "address1": address1,
                        "familyname": familyname,
                        "middlename": middlename,
                        "lastviewed": lastviewed,
                        "postalcode": postalcode,
                        "givenname": givenname,
                        "state": state
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
    open class func getPatient(uuid: String, v: String? = nil, completion: @escaping ((_ data: PatientGet?, _ error: ErrorResponse?) -> Void)) {
        getPatientWithRequestBuilder(uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch by uuid
     - GET /patient/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<PatientGet> 
     */
    open class func getPatientWithRequestBuilder(uuid: String, v: String? = nil) -> RequestBuilder<PatientGet> {
        var path = "/patient/{uuid}"
        let uuidPreEscape = "\(uuid)"
        let uuidPostEscape = uuidPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{uuid}", with: uuidPostEscape, options: .literal, range: nil)
        let URLString = OpenMRSAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "v": v
        ])

        let requestBuilder: RequestBuilder<PatientGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch allergy subresources by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPatientAllergy(parentUuid: String, uuid: String, v: String? = nil, completion: @escaping ((_ data: PatientAllergyGet?, _ error: ErrorResponse?) -> Void)) {
        getPatientAllergyWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch allergy subresources by uuid
     - GET /patient/{parent-uuid}/allergy/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<PatientAllergyGet> 
     */
    open class func getPatientAllergyWithRequestBuilder(parentUuid: String, uuid: String, v: String? = nil) -> RequestBuilder<PatientAllergyGet> {
        var path = "/patient/{parent-uuid}/allergy/{uuid}"
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

        let requestBuilder: RequestBuilder<PatientAllergyGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Fetch identifier subresources by uuid
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPatientIdentifier(parentUuid: String, uuid: String, v: String? = nil, completion: @escaping ((_ data: PatientIdentifierGet?, _ error: ErrorResponse?) -> Void)) {
        getPatientIdentifierWithRequestBuilder(parentUuid: parentUuid, uuid: uuid, v: v).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Fetch identifier subresources by uuid
     - GET /patient/{parent-uuid}/identifier/{uuid}
     - BASIC:
       - type: http
       - name: basic_auth
     - parameter parentUuid: (path) parent resource uuid 
     - parameter uuid: (path) uuid to filter by 
     - parameter v: (query) The representation to return (ref, default, full or custom) (optional)
     - returns: RequestBuilder<PatientIdentifierGet> 
     */
    open class func getPatientIdentifierWithRequestBuilder(parentUuid: String, uuid: String, v: String? = nil) -> RequestBuilder<PatientIdentifierGet> {
        var path = "/patient/{parent-uuid}/identifier/{uuid}"
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

        let requestBuilder: RequestBuilder<PatientIdentifierGet>.Type = OpenMRSAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
