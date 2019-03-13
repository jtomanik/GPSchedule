//
//  RootViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: GenericViewController<RootViewModel> {

    private lazy var logInView: LoginViewController = {
        let vm = LoginViewModel(parent: viewModel)
        return LoginViewController(viewModel: vm)
    }()
    private lazy var loggedInView: LoggedInViewController = {
        let vm = LoggedInViewModel(parent: viewModel)
        return LoggedInViewController(viewModel: vm)
    }()
    private lazy var loadingView: LoadingViewController = {
        let vm = LoadingViewModel(parent: viewModel)
        return LoadingViewController(viewModel: vm)
    }()
    private lazy var errorView: ErrorViewController = {
        let vm = ErrorViewModel(parent: viewModel)
        return ErrorViewController(viewModel: vm)
    }()

    override func setupView() {
        self.addChild(logInView)
        logInView.didMove(toParent: self)
        view.addSubview(logInView.view)
        logInView.view.pinToEdges(of: view)
        hideLogInView()

        self.addChild(loggedInView)
        loggedInView.didMove(toParent: self)
        view.addSubview(loggedInView.view)
        loggedInView.view.pinToEdges(of: view)
        hideLoggedInView()
    }

    override func process(state: RootViewModel.State) {
        switch state {
        case .logIn:
            hideLoggedInView()
            showLogInView()
            hideLoadingView()
        case .loggedIn:
            hideLogInView()
            showLoggedInView()
            hideLoadingView()
        case .error(let error):
            showErrorView()
        case .loading:
            showLoadingView()
        }
    }

    private func showLogInView() {
        logInView.view.isUserInteractionEnabled = true
        logInView.view.isHidden = false
    }
    private func hideLogInView() {
        logInView.view.isUserInteractionEnabled = false
        logInView.view.isHidden = true
    }
    private func showLoggedInView() {
        loggedInView.view.isUserInteractionEnabled = true
        loggedInView.view.isHidden = false
    }
    private func hideLoggedInView() {
        loggedInView.view.isUserInteractionEnabled = false
        loggedInView.view.isHidden = true
    }
    private func showErrorView() {
        self.present(errorView,
                     animated: true,
                     completion: nil)
    }
    private func hideErrorView() {
        errorView.dismiss(animated: true,
                          completion: nil)
    }
    private func showLoadingView() {
        self.present(loadingView,
                     animated: true,
                     completion: nil)
    }
    private func hideLoadingView() {
        loadingView.dismiss(animated: true,
                          completion: nil)
    }
}
