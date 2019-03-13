//
//  LoggedInViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

// sourcery: viewName = "LoggedIn"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "none"
enum LoggedInViewState: BasicViewGenerator {
    case none
    
    enum UserAction: Event, Equatable {
    }
}

extension LoggedInViewState: ViewState {
    init() {
        self = .none
    }
}

class LoggedInViewModel: GenericChildViewModel<LoggedInViewState, RootViewModel> {
    convenience init(parent: RootViewModel) {
        self.init(parent: parent, transformer: nil, reducer: nil)
    }

    required convenience init(parent: Parent, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
        self.init(store: parent.store, transformer: transformer, reducer: reducer)
        self.parent = parent
    }

    required init(store: Store, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
        super.init(store: store, transformer: transformer, reducer: reducer)
    }
}

class LoggedInViewController: GenericViewController<LoggedInViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.red
    }

    override func process(state: LoggedInViewModel.State) {
        return
    }
}
