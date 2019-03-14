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
    typealias Model = User

    static func logIn(username: String, password: String) -> Authenticator {
        return Authenticator(username: username, password: password)
    }

    private init(username: String, password: String) {
        let credential = URLCredential(user: username, password: password, persistence: URLCredential.Persistence.permanent)
        OpenMRSAPI.credential = credential
    }

    func execute() -> Single<User> {
        return Observable<User>.create { observer -> Disposable in
            UserAPI.getAllUsersWithRequestBuilder(limit: nil, startIndex: nil, v: nil, q: nil, username: nil)
                .addCredential()
                .execute { (response, error) in
                    if let error = error {
                        observer.on(.error(error))
                    } else {
                        if let response = response,
                            let fetchAll = response.body {
                            print(fetchAll)
//                            observer.onNext(User(username:"dupa"))
                        } else {
                            observer.onError(AuthError.unknown)
                        }
                        //observer.on(.next(data!))
                    }
                    observer.on(.completed)
            }
            return Disposables.create()
        }
        .asSingle()
    }
}
