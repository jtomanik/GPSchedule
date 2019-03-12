//
//  UIElementsStates.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

struct TextFieldState: Comparable {
    var placeholder: String?
    var text: String?
    var isEnabled: Bool
}

struct ButtonState: Comparable {
    var text: String?
    var isEnabled: Bool
}

struct LabelState: Comparable {
    var text: String?
    var isHidden: Bool
}
