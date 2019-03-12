//
//  ErrorViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

// sourcery: viewName = "Error"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "none"
enum ErrorViewState: BasicViewGenerator {
    case none

    enum UserAction: Event {
    }
}

extension ErrorViewState: ViewState {
    init() {
        self = .none
    }
}

class ErrorViewModel: GenericChildViewModel<ErrorViewState, RootViewModel> {

}

class ErrorViewController: GenericViewController<ErrorViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.black
    }

    override func process(state: ErrorViewModel.State) {
        return
    }
}
