//
//  DomainWarehouse.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

class DomainWarehouse: DomainStoreFacade {

    let authService = Authenticator.self
    var rootUseCase: RootUseCase!

    init() {
        self.rootUseCase = RootUseCase(initialState: RootState(), dependencyProvider: self)
    }
}

extension DomainWarehouse {
    func dispatch(event: Event) {
        switch event {
        case let event as RootState.DomainEvent:
            rootUseCase.dispatch(event: event)
        default:
            return
        }
    }
}

extension DomainWarehouse: RootUseCaseDependenciesProvider {}
