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
    @IBOutlet weak var timeFrom: UILabel!
    @IBOutlet weak var timeTo: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
}

class AppointmentComponent: GenericComponent<AppointmentComponentState, AppointmentComponentView> {

    override func render(in view: AppointmentComponentView) {
        view.timeFrom.text = state.timeFrom
        view.timeTo.text = state.timeTo
        view.title.text = state.title
        view.subtitle.text = state.subtitle
    }
}
