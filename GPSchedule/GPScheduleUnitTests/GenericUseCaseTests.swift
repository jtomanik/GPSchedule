//
//  GenericUseCaseTests.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 23/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation
import Quick
import Nimble
import RxSwift
import RxOptional

class GenericUseCaseSpec: QuickSpec {
    override func spec() {

        // UseCase stores the current state of a speciffic business process
        describe("UseCase") {

            var useCase: GenericUseCase<MockState>!
            let warehouse = MockWarehouse()

        // It's state can be changed only by the reduce funtion that produces a new state based on the current and a new event
            describe("has state reducer") {

                beforeEach {
                    useCase = GenericUseCase.init(
                        initialState: MockState.initial,
                        warehouse: nil,
                        reducer: reduce,
                        middleware: [],
                        feedbackLoop: [])
                }

                it("that changes current state after receiving an event") {
                    useCase.dispatch(event: .first)
                    let context = useCase.state.value.events
                    expect(context.count).toNot(equal(0))
                }

                it("that changes current state only once") {
                    useCase.dispatch(event: .first)
                    let context = useCase.state.value.events
                    expect(context.count).to(equal(1))
                    expect(context[.first]).to(equal(1))
                }

                it("that changes current state corectly more than once") {
                    useCase.dispatch(event: .first)
                    useCase.dispatch(event: .first)
                    let context = useCase.state.value.events
                    expect(context.count).to(equal(1))
                    expect(context[.first]).to(equal(2))
                }
            }

        // New  events can be transformed into different ones by middlewares before they can reach the reducer
            describe("has event middlewares") {
                context("when there is at least one") {

                    beforeEach {
                        useCase = GenericUseCase.init(
                            initialState: MockState.initial,
                            warehouse: nil,
                            reducer: reduce,
                            middleware: [middleware1],
                            feedbackLoop: [])
                    }

                    it("that changes dispatched event to a different one") {
                        useCase.dispatch(event: .first)
                        let context = useCase.state.value.events
                        expect(context.count).to(equal(1))
                        expect(context[.second]).to(equal(1))
                    }
                }

                context("When there is more than one") {

                    beforeEach {
                        useCase = GenericUseCase.init(
                            initialState: MockState.initial,
                            warehouse: nil,
                            reducer: reduce,
                            middleware: [middleware1, middleware2],
                            feedbackLoop: [])
                    }

                    it("that all are run in paralel") {
                        useCase.dispatch(event: .first)
                        let context = useCase.state.value.events
                        expect(context.count).to(equal(2))
                        expect(context[.first]).to(equal(1))
                        expect(context[.second]).to(equal(1))
                    }
                }
            }

        // State changes can be used to trigger other UseCases by sending events, via DomainWarehouse, from the feedback functions
        // TODO: Test for the case where we have more than one feedback function
            describe("state feedback") {

                beforeEach {
                    useCase = GenericUseCase.init(
                        initialState: MockState.initial,
                        warehouse: warehouse,
                        reducer: reduce,
                        middleware: [middleware2],
                        feedbackLoop: [feedback1])
                }

                it("sends an event to the Warehouse") {
                    useCase.dispatch(event: .second)
                    expect(warehouse.mockUseCase.state.value).toEventually(equal(.alpha))
                }
            }
        }
    }
}

func middleware1(_ event: MockState.StateEvent) -> Observable<MockState.StateEvent> {
    if case .first = event {
        return Observable.just(.second)
    } else {
        return Observable.just(event)
    }
}

func middleware2(_ event: MockState.StateEvent) -> Observable<MockState.StateEvent> {
    if case .second = event {
        return Observable.just(.third)
    } else {
        return Observable.just(event)
    }
}

func reduce(_ state: MockState, _ event: MockState.StateEvent) -> MockState {
    switch (state, event) {
    case (.initial, _):
        return .received(events: [event: 1])
    case (.received(let events), _):
        let newCount: [MockState.StateEvent: Int] = [event: (events[event].value ?? 0) + 1]
        let events = events.merging(newCount, uniquingKeysWith: { max($0, $1) })
        return .received(events: events)
    }
}

func feedback1(state: MockState) -> Observable<DomainEvent> {
    if case MockState.received(let events) = state,
        let count = events[.third].value,
        count == 1 {
        return Observable.just(AnotherMockState.StateEvent.alpha)
    } else {
        return Observable.empty()
    }
}

func feedback2(state: MockState) -> Observable<DomainEvent> {
    if case MockState.received(let events) = state,
        let count = events[.third].value,
        count == 2 {
        return Observable.just(AnotherMockState.StateEvent.beta)
    } else {
        return Observable.empty()
    }
}
