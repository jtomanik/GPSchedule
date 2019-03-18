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

    typealias RowId = String
    typealias SectionId = String

    override func process(state: LoggedInViewModel.State) {
        switch state {
        case .empty(let title):
            self.title = title
            tableView.render(noBoxes())
        case .refreshing(let title, _):
            self.title = title
            tableView.render(loadingBoxes())
        case .list(let model, _):
            self.title = model.title
            tableView.render(package(model: model))
        case .fetching:
            tableView.render(loadingBoxes())
        case .detail(let model):
            tableView.render(package(model: model))
        }
    }

    private func package(model: LoggedInViewState.ListDisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
                |-+ Section(id: "Appointments")
                |---* model.items.map { self.package(model: $0) }
    }

    private func package(model: AppointmentComponentState) -> Node<RowId> {
        return RowId(model.id) <> AppointmentComponent(state: model)
    }

    private func package(model: LoggedInViewState.DetailDisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }

    private func loadingBoxes() -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
            |-+ Section(id: "loading")
            |---+ RowId("0") <> LoadingComponent(state: true)
    }

    private func noBoxes() -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
                |-+ Section(id: "empty")
                |---+ RowId("0") <> LabelComponent(
                    state: LabelState(text: "No data available", isHidden: false))

    }
}
