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
        return Observable<User>.create { [username] observer -> Disposable in
            UserAPI.getAllUsersWithRequestBuilder(limit: nil, startIndex: nil, v: "full", q: nil, username: username)
                .addCredential()
                .execute { (response, error) in
                    if let error = error {
                        observer.on(.error(error))
                    } else {
                        if let response = response,
                            let results = response.body?.results {
                            let decoded = Decoders.decode(clazz: Array<UserGet>.self, source: results as AnyObject)
                            switch decoded {
                            case .success(let value):
                                if let user = value.first {
                                    observer.onNext(user)
                                } else {
                                    observer.onError(AuthError.unknown)
                                }
                            case .failure(let error):
                                observer.onError(AuthError.unknown)
                            }
                        } else {
                            observer.onError(AuthError.unknown)
                        }
                    }
                    observer.on(.completed)
            }
            return Disposables.create()
        }
        .asSingle()
    }
}
