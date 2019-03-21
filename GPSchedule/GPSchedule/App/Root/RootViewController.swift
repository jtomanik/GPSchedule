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
        let childViewModel = LoginViewModel(parent: viewModel)
        return LoginViewController(viewModel: childViewModel)
    }()

    private lazy var loggedInView: UINavigationController = {
        let childViewModel = CalendarViewModel(parent: viewModel)
        let view = CalendarViewController(viewModel: childViewModel)
        return UINavigationController(rootViewController: view)
    }()

    private lazy var loadingView: LoadingViewController = {
        let childViewModel = LoadingViewModel(parent: viewModel)
        return LoadingViewController(viewModel: childViewModel)
    }()

    private lazy var errorView: ErrorViewController = {
        let childViewModel = ErrorViewModel(parent: viewModel)
        return ErrorViewController(viewModel: childViewModel)
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
            showLogInView()
        case .loggedIn:
            showLoggedInView()
        case .error:
            showErrorView()
        case .loading:
            showLoadingView()
        }
    }

    private func showLogInView() {
        logInView.view.isUserInteractionEnabled = true
        logInView.view.isHidden = false
        hideLoadingView()
        hideErrorView()
    }
    private func hideLogInView() {
        logInView.view.isUserInteractionEnabled = false
        logInView.view.isHidden = true
    }
    private func showLoggedInView() {
        loggedInView.view.isUserInteractionEnabled = true
        loggedInView.view.isHidden = false
        hideLoadingView()
        hideErrorView()
    }
    private func hideLoggedInView() {
        loggedInView.view.isUserInteractionEnabled = false
        loggedInView.view.isHidden = true
    }
    private func showErrorView() {
        guard errorView.presentingViewController == nil else {
            return
        }
        if loadingView.presentingViewController != nil {
            hideLoadingView(animated: false)
            self.present(errorView,
                         animated: false,
                         completion: nil)
        } else {
            self.present(errorView,
                         animated: true,
                         completion: nil)
        }
    }
    private func hideErrorView(animated: Bool = true) {
        errorView.dismiss(animated: animated,
                          completion: nil)
    }
    private func showLoadingView() {
        guard loadingView.presentingViewController == nil else {
            return
        }
        if errorView.presentingViewController != nil {
            hideErrorView(animated: false)
            self.present(loadingView,
                         animated: false,
                         completion: nil)
        } else {
            self.present(loadingView,
                         animated: true,
                         completion: nil)
        }

    }
    private func hideLoadingView(animated: Bool = true) {
        loadingView.dismiss(animated: animated,
                          completion: nil)
    }
}
