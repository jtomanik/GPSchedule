//
//  GenericViewModelTests.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 24/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation
import Quick
import Nimble
import RxSwift
import RxOptional

class GenericViewModelSpec: QuickSpec {
    override func spec() {
        // View Model stores the current state of a particular View (UIViewController) or a number of views
        describe("ViewModel") {

            var viewModel: GenericViewModel<MockViewState, MockUseCase>!
            var warehouse: MockWarehouse!

        // VM's state can be changed in reaction to the state changes of the associated UseCase
            describe("has UseCase state transformer") {

                beforeEach {
                    warehouse = MockWarehouse()
                    viewModel = GenericViewModel.init(initialState: MockViewState.initial,
                                                      warehouse: warehouse,
                                                      transformer: transform,
                                                      reducer: nil,
                                                      forwarder: nil)
                }

                it("that changes current stated based on UseCase's state changes") {
                    warehouse.mockUseCase.dispatch(event: AnotherMockState.StateEvent.alpha)
                    let state = viewModel.state.value
                    expect(state).to(equal(.changedByTheUseCase))
                }
            }

        // VM' state can be changed by the user actions sent by the View
            describe("has user action reducer") {

                beforeEach {
                    warehouse = MockWarehouse()
                    viewModel = GenericViewModel.init(initialState: MockViewState.initial,
                                                      warehouse: warehouse,
                                                      transformer: nil,
                                                      reducer: reduce,
                                                      forwarder: nil)
                }

                it("that changes current state after receiving an event") {
                    viewModel.dispatch(action: .firstAction)
                    let actions = viewModel.state.value.actions
                    expect(actions.count).toNot(equal(0))
                }

                it("that changes current state only once") {
                    viewModel.dispatch(action: .firstAction)
                    let actions = viewModel.state.value.actions
                    expect(actions.count).to(equal(1))
                    expect(actions[.firstAction]).to(equal(1))
                }

                it("that changes current state correctly more than once") {
                    viewModel.dispatch(action: .firstAction)
                    viewModel.dispatch(action: .secondAction)
                    let actions = viewModel.state.value.actions
                    expect(actions.count).to(equal(2))
                    expect(actions[.firstAction]).to(equal(1))
                    expect(actions[.secondAction]).to(equal(1))
                }
            }

        // VM' state can be used to trigger side effects using a forwarder
            describe("has state forwarder") {
                struct ReportedResult: Equatable {
                    let state: MockViewState
                    let action: MockViewState.UserAction
                }
                var reported: ReportedResult?

                beforeEach {
                    reported = nil
                    warehouse = MockWarehouse()
                    viewModel = GenericViewModel.init(initialState: MockViewState.initial,
                                                      warehouse: warehouse,
                                                      transformer: nil,
                                                      reducer: reduce,
                                                      forwarder: forward(callback: { state, action in
                                                        reported = ReportedResult(state: state, action: action)
                                                      }))
                }

                it("that receive state and last action") {
                    viewModel.dispatch(action: .firstAction)
                    let expected = ReportedResult(state: viewModel.state.value, action: .firstAction)
                    expect(reported).toEventually(equal(expected))
                }
            }
        }
    }
}

func transform(storeState: AnotherMockState, state: MockViewState) -> MockViewState {
    if case AnotherMockState.alpha = storeState {
        return .changedByTheUseCase
    } else {
        return state
    }
}

func reduce(state: MockViewState, action: MockViewState.UserAction) -> MockViewState {
    switch (state, action) {
    case (.initial, _):
        return .received(actions: [action: 1])
    case (.changedByTheUseCase, _):
        return .received(actions: [action: 1])
    case (.received(let actions), _):
        let newCount: [MockViewState.UserAction: Int] = [action: (actions[action].value ?? 0) + 1]
        let newActions = actions.merging(newCount, uniquingKeysWith: { max($0, $1) })
        return .received(actions: newActions)
    }
}

func forward(callback: @escaping ((MockViewState, MockViewState.UserAction) -> ())) -> ViewStateForwarder<MockViewState> {
    return { (object: AnyObject?, state: MockViewState, lastAction: MockViewState.UserAction) in
        callback(state, lastAction)
    }
}
