//
//  LoadingViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

// sourcery: viewName = "Loading"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "none"
enum LoadingViewState: BasicViewGenerator {
    case none

    enum UserAction: Event {
    }
}

extension LoadingViewState: ViewState {
    init() {
        self = .none
    }
}

class LoadingViewModel: GenericChildViewModel<LoadingViewState, RootViewModel> {

}

class LoadingViewController: GenericViewController<LoadingViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.green
    }

    override func process(state: LoadingViewModel.State) {
        return
    }
}
