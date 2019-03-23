//
//  AppointmentDetailViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 18/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Bento
import BentoKit

class AppointmentDetailViewController: GenericTableViewController<CalendarViewModel> {

    typealias RowId = String
    typealias SectionId = String

    override func process(state: CalendarViewModel.State) {
        switch state {
        case .fetching:
            tableView.render(loadingBoxes())
        case .detail(let model, _, _):
            self.title = model.title.text
            tableView.render(package(model: model))
        default:
            tableView.render(noBoxes())
        }
    }

    private func package(model: CalendarViewState.DetailDisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
            |-+ Section(id: "details")
            |---+ RowId("0") <> LabelComponent(state: model.brief)
            |---+ RowId("1") <> LabelComponent(state: model.startDate)
            |---+ RowId("2") <> LabelComponent(state: model.endDate)
            |---+ RowId("3") <> LabelComponent(state: model.timeslotText)
            |---+ RowId("4") <> LabelComponent(state: model.brief)
            |---+ RowId("5") <> LabelComponent(state: model.appointmenText)
            |---+ RowId("6") <> LabelComponent(state: model.reason)
    }

    private func loadingBoxes() -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
            |-+ Section(id: "loading")
            |---+ RowId("0") <> LoadingComponent(state: true)
    }

    private func noBoxes() -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
    }
}
