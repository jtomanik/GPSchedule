//
//  AppointmentComponent.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 17/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import UIKit
import Bento

final class AppointmentComponentView: UIView, NibLoadable {
    // swiftlint:disable empty_parameters
    @IBOutlet weak var timeFrom: UILabel!
    @IBOutlet weak var timeTo: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    var onPressed: ((Void) -> Void)?

    @IBAction func userDidTap(_ sender: Any) {
        onPressed?(())
    }
    // swiftlint:enable empty_parameters
}

class AppointmentComponent: GenericActionableComponent<AppointmentComponentState, String, AppointmentComponentView> {

    override func render(in view: AppointmentComponentView) {
        view.timeFrom.text = state.timeFrom
        view.timeTo.text = state.timeTo
        view.title.text = state.title
        view.subtitle.text = state.subtitle
        view.onPressed = { [didUpdate, state] (_) -> Void in didUpdate?(state.id) }
    }
}
