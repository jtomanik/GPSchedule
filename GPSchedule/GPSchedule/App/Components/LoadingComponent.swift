//
//  LoadingComponent.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 17/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import UIKit
import Bento

final class LoadingComponentView: UIView, NibLoadable {
    @IBOutlet weak var activity: UIActivityIndicatorView!
}

class LoadingComponent: GenericComponent<Bool, LoadingComponentView> {

    override func render(in view: LoadingComponentView) {
        if state {
            view.activity.startAnimating()
        } else {
            view.activity.stopAnimating()
        }
    }
}
