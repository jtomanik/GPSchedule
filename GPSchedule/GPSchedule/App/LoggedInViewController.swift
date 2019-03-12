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
    
    enum UserAction: Event {
    }
}

extension LoggedInViewState: ViewState {
    init() {
        self = .none
    }
}

class LoggedInViewModel: GenericChildViewModel<LoggedInViewState, RootViewModel> {

}

class LoggedInViewController: GenericViewController<LoggedInViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.red
    }

    override func process(state: LoggedInViewModel.State) {
        return
    }
}
