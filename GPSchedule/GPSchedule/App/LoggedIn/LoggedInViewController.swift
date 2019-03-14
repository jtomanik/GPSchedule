//
//  LoggedInViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Bento
import BentoKit

class LoggedInViewController: GenericTableViewController<LoggedInViewModel> {

    override func process(state: LoggedInViewModel.State) {
        let boxedState = package(model: state.context)
        tableView.render(boxedState)
    }

    private func package(model: LoggedInViewState.DisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }
}
