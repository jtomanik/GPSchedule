//
//  OpenMRS+Rx.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 15/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS
import RxSwift

extension RequestBuilder {

    public func rx() -> Observable<T?> {
        return Observable<T?>.create { observer -> Disposable in
            self.execute { (response, error) in
                    if let error = error {
                        observer.onError(error)
                    } else {
                        let result = response?.body
                        observer.onNext(result)
                    }
                    observer.on(.completed)
            }
            return Disposables.create()
        }
    }
}
