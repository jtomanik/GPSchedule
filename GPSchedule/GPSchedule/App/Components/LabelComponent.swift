//
//  LabelComponent.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 12/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import UIKit
import Bento

final class LabelComponentView: UIView, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
}

class LabelComponent: GenericComponent<LabelState, LabelComponentView> {

    override func render(in view: LabelComponentView) {
        view.titleLabel.text = state.text
        view.titleLabel.isHidden = state.isHidden
    }
}
