//
//  LogInViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxSwiftExt

class LoginViewController: GenericViewController<LoginViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.blue
    }

    override func process(state: LoginViewModel.State) {
        return
    }
}
