//
//  AuthService.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 14/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS
import RxSwift

struct Authenticator: AuthService {

    private let username: String

    static func logIn(username: String, password: String) -> Authenticator {
        return Authenticator(username: username, password: password)
    }

    private init(username: String, password: String) {
        self.username = username
        let credential = URLCredential(user: username, password: password, persistence: URLCredential.Persistence.permanent)
        OpenMRSAPI.credential = credential
    }

    func execute() -> Single<User> {
        return UserAPI
            .getAllUsersWithRequestBuilder(v: "full", username: username)
            .addCredential()
            .rx()
            .errorOnNil(APIError.backendError)
            .map { $0.results }
            .filterNil()
            .map { Decoders.decode(clazz: Array<UserGet>.self, source: $0 as AnyObject) }
            .map { $0.value }
            .errorOnNil(APIError.parsingError)
            .map { $0.first }
            .errorOnNil(APIError.noData)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
