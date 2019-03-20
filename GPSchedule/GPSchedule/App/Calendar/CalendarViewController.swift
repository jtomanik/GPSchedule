//
//  CalendarViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Bento
import BentoKit

class CalendarViewController: GenericTableViewController<CalendarViewModel> {

    typealias RowId = String
    typealias SectionId = String

    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return view
    }()

    private lazy var detailView: AppointmentDetailViewController = {
        return AppointmentDetailViewController(viewModel: self.viewModel)
    }()

    override func setupView() {
        super.setupView()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let state = viewModel.state.value
    }

    override func process(state: CalendarViewModel.State) {
        self.refreshControl.endRefreshing()
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
        case .detail:
            showDetailView()
        }
    }

    private func package(model: CalendarViewState.ListDisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
                |-+ Section(id: "Appointments")
                |---* model.items.map { self.package(model: $0) }
    }

    private func package(model: AppointmentComponentState) -> Node<RowId> {
        return RowId(model.id) <> AppointmentComponent(state: model,
                                                       didUpdate: { [weak self] in self?.userDidTap(on: $0) })
    }

    private func package(model: CalendarViewState.DetailDisplayModel) -> Box<SectionId, RowId> {
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

    private func userDidTap(on appointmentId: String) {
        viewModel.dispatch(action: CalendarViewState.UserAction.showDetail(id: appointmentId))
    }

    private func showDetailView() {
        navigationController?.pushViewController(detailView, animated: true)
    }

    @objc
    private func refreshData() {
        viewModel.dispatch(action: CalendarViewState.UserAction.refresh)
    }
}
