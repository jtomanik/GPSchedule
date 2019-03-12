//
//  RootViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class RootViewController: GenericViewController<RootViewModel> {

    private lazy var logInView: LoginViewController = {
        let vm = LoginViewModel(parent: viewModel)
        return LoginViewController(viewModel: vm)
    }()

    override func setupView() {
        self.addChild(logInView)
        logInView.didMove(toParent: self)
        view.addSubview(logInView.view)
        constrain(logInView.view) { view in
            view.edges == inset(view.superview!.edges, 0)
        }
        logInView.view.isUserInteractionEnabled = false
    }

    override func process(state: RootViewModel.State) {
        switch state {
        case .logIn:
            showLogInView()
        case .loggedIn:
            showLoggedInView()
        case .error(let error):
            showErrorView(error: error)
        case .loading:
            showLoadingView()
        }
    }

    private func showLogInView() {
        return
    }
    private func showLoggedInView() {}
    private func showErrorView(error: Error) {}
    private func showLoadingView() {}
}
