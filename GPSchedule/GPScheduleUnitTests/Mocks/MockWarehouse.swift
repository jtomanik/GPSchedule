//
//  MockWarehouse.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 23/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation
import XCTest
import RxSwift

class MockWarehouse: DomainStoreFacade {
// swiftlint:disable all

    var eventLog: [DomainEvent] = []

    let mockService = MockingSource.self

    var mockUseCase: MockUseCase!

    private let disposeBag = DisposeBag()

    init() {
        self.mockUseCase = MockUseCase(initialState: AnotherMockState(), warehouse: self,  dependencyProvider: self)
    }

    func getStore<S>(for type: S.Type) -> S {
        switch type {
        case is MockUseCase.Type:
            return mockUseCase! as! S
        default:
            fatalError("Store type is not a part of a Warehouse")
        }
    }

    func dispatch(event: DomainEvent) {
        eventLog.append(event)
        switch event {
        case let event as AnotherMockState.StateEvent:
            mockUseCase.dispatch(event: event)
        default:
            return
        }
    }

    func resetEventLog() {
        eventLog = []
    }
// swiftlint:enable all
}

extension MockWarehouse: MockServiceProvider {}
extension MockWarehouse: MockUseCaseDependenciesProvider {}
