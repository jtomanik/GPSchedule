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

class LoginViewController: GenericTableViewController<LoginViewModel> {

    typealias RowId = Int
    typealias SectionId = Int

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
        viewModel.dispatch(action: .usernameEntry(text))
    }

    private func passwordFieldChanged(text: String?) {
        viewModel.dispatch(action: .passwordEntry(text))
    }

    private func loginButtonTapped() {
        viewModel.dispatch(action: .loginButtonPressed)
    }
}

fileprivate extension LoginViewState {

    var context: DisplayModel {
        switch self {
        case .inProgress(let displayModel): return displayModel
        case .done(let displayModel): return displayModel
        }
    }
}
