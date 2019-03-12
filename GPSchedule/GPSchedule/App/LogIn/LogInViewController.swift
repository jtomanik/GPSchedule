//
//  LogInViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Bento
import BentoKit

class LoginViewController: GenericViewController<LoginViewModel> {

    typealias RowId = Int
    typealias SectionId = Int

    private lazy var tableView: BentoTableView = {
        let table = BentoTableView()
        return table
    }()

    override func setupView() {
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
    }

    override func process(state: LoginViewModel.State) {
        let boxedState = package(model: state.context)
        tableView.render(boxedState)
    }

    private func package(model: LoginViewState.DisplayModel) -> Box<SectionId, RowId> {
        return Box<SectionId, RowId>.empty
        |-+ Section(id: 0)
        |---+ RowId(0) <> LabelComponent(state: model.title)
        |---+ RowId(1) <> TextInputComponent(state: model.usernameField, didUpdate: self.loginFieldChanged)
        |---+ RowId(2) <> TextInputComponent(state: model.passwordField, didUpdate: self.passwordFieldChanged)
        |---+ RowId(3) <> LabelComponent(state: model.errorMessage)
            |---+ RowId(4) <> ButtonComponent(state: model.loginButton, didUpdate: self.loginButtonTapped)
    }

    private func loginFieldChanged(text: String?) {
        viewModel.action.onNext(.usernameEntry(text))
    }

    private func passwordFieldChanged(text: String?) {
        viewModel.action.onNext(.passwordEntry(text))
    }

    private func loginButtonTapped() {
        viewModel.action.onNext(.loginButtonPressed)
    }
}
