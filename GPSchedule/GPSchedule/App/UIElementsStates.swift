//
//  UIElementsStates.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

struct TextFieldState {
    var placeholder: String?
    var text: String?
    var isEnabled: Bool
}

struct ButtonState {
    var text: String?
    var isEnabled: Bool
}

struct LabelState {
    var text: String?
    var isHidden: Bool
}
