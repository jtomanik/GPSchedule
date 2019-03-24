//
//  ButtonComponent.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 12/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import UIKit
import Bento

final class ButtonComponentView: UIView, NibLoadable {
    // swiftlint:disable empty_parameters
    @IBOutlet weak var button: UIButton!

    var onButtonPressed: ((Void) -> Void)?

    @IBAction func buttonPressed(_ sender: Any) {
        onButtonPressed?(())
    }
    // swiftlint:enable empty_parameters
}

class ButtonComponent: GenericActionableComponent<ButtonState, Void, ButtonComponentView> {

    override func render(in view: ButtonComponentView) {
        view.button.setTitle(state.text, for: .normal)
        view.button.isEnabled = state.isEnabled
        view.onButtonPressed = self.didUpdate
    }
}
