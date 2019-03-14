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
// sourcery: defaultState = "none"
enum LoggedInViewState: BasicViewGenerator, ViewState {

    struct DisplayModel: Equatable {

    }

    case none

    enum UserAction: Event, Equatable {
    }

    // sourcery:inline:auto:LoggedInViewState.AutoInit
        init() {
            self = .none
        }
    // sourcery:end
}

extension LoggedInViewState {
    var context: DisplayModel {
        return DisplayModel()
    }
}

class LoggedInViewModel: GenericChildViewModel<LoggedInViewState, RootViewModel> {

    static func transform(storeState: RootState, state: State) -> State {
        return state
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        return state
    }

// sourcery:inline:auto:LoggedInViewModel.AutoInit
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
// sourcery:end
}
