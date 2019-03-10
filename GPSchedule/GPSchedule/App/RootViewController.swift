//
//  RootViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxSwiftExt

// sourcery: viewmodel = "RootViewModel"
class RootViewController: UIViewController, AppView {

    private lazy var logInView: LoginViewController = {
        let vm = LoginViewModel(store: viewModel.store)
        return LoginViewController(viewModel: vm)
    }()

    // sourcery:inline:RootViewController.AppView
    private(set) var viewModel: RootViewModel
    private(set) var disposeBag = DisposeBag()
    
    required init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // sourcery:end


    }

    func setupView() {
    }

    func bindToViewModel() {
        viewModel.state
            .subscribe(
                weak: self,
                onNext: { return $0.process },
                onError: { (_) -> (Error) -> Void in fatalError("Unhandled error has occured") },
                onCompleted: { (_) -> () -> Void in fatalError("Root state must not compleate while application is running") },
                onDisposed: { (_) -> () -> Void in fatalError("Root state must not be disposed while application is running") })
            .disposed(by: disposeBag)
    }

    private func process(state: RootViewModel.State) {
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

    }
    private func showLoggedInView() {}
    private func showErrorView(error: Error) {}
    private func showLoadingView() {}
}
