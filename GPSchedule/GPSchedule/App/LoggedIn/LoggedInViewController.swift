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
        switch state {
        case .empty:
            tableView.render(noBoxes())
        case .refreshing:
            tableView.render(loadingBoxes())
        case .list(let model, _):
            tableView.render(package(model: model))
        case .fetching:
            tableView.render(loadingBoxes())
        case .detail(let model):
            tableView.render(package(model: model))
        }
    }

    private func package(model: LoggedInViewState.ListDisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }

    private func package(model: LoggedInViewState.DetailDisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }

    private func loadingBoxes() -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }

    private func noBoxes() -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }
}
