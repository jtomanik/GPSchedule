//
//  MockUseCase.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 24/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation

protocol MockUseCaseDependenciesProvider: MockServiceProvider {}

// sourcery: defaultState = "AnotherMockState"
class MockUseCase: GenericUseCase<AnotherMockState> {

    convenience init<DependenciesProvider: MockUseCaseDependenciesProvider>(
        initialState: State,
        warehouse: DomainStoreFacade,
        dependencyProvider: DependenciesProvider) {

        func reduce(_ state: AnotherMockState, _ event: AnotherMockState.StateEvent) -> AnotherMockState {
            switch event {
            case .alpha:
                return .alpha
            case .beta:
                return .beta
            }
        }

        self.init(
            initialState: initialState,
            warehouse: warehouse,
            reducer: reduce,
            middleware: [],
            feedbackLoop: [])
    }

    required init(initialState: State,
                  warehouse: DomainStoreFacade?,
                  reducer: @escaping DomainStateReducer<State>,
                  middleware: [DomainStateMiddleware<State>],
                  feedbackLoop: [DomainStateFeedback<State>]) {
        super.init(initialState: initialState,
                   warehouse: warehouse,
                   reducer: reducer,
                   middleware: middleware,
                   feedbackLoop: feedbackLoop)
    }
}
