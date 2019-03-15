//
//  LoggedInViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

// sourcery: viewName = "LoggedIn"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "empty"
enum LoggedInViewState: BasicViewGenerator, ViewState {

    struct ListDisplayModel: Equatable {

        init() {

        }
    }

    struct DetailDisplayModel: Equatable {

        init() {

        }
    }

    case empty
    case refreshing(for: User)
    case list(ListDisplayModel, for: User)
    case fetching(id: String)
    case detail(DetailDisplayModel)

    enum UserAction: Event, Equatable {
        case refresh
        case showDetail(id: String)
    }

    // sourcery:inline:auto:LoggedInViewState.AutoInit
        init() {
            self = .empty
        }
    // sourcery:end
}

class LoggedInViewModel: GenericChildViewModel<LoggedInViewState, RootViewModel> {

    static func transform(storeState: RootState, state: State) -> State {
        switch storeState {
        case .authorized(let user):
            return .refreshing(for: user)
        default:
            return state
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .refresh:
            if case LoggedInViewState.list(_, let user) = state {
                return .refreshing(for: user)
            } else {
                return state
            }
        case .showDetail(let id):
            return .fetching(id: id)
        }
    }

    override func forwarder(state: LoggedInViewState) {
        switch state {
        case .refreshing(let user):
            return
        case .fetching(let id):
            return
        default:
            return
        }
    }

// sourcery:inline:auto:LoggedInViewModel.AutoInit
// swiftlint:disable all
convenience init(parent: RootViewModel) {
    self.init(parent: parent, transformer: LoggedInViewModel.transform, reducer: LoggedInViewModel.reduce)
}

required convenience init(parent: Parent, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
    self.init(store: parent.store, transformer: transformer, reducer: reducer)
    self.parent = parent
}

required init(store: Store, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
    super.init(store: store, transformer: transformer, reducer: reducer)
}
// swiftlint:enable all
// sourcery:end

}
