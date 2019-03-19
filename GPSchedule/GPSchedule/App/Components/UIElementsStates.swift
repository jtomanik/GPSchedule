//
//  UIElementsStates.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

struct TextInputState: Equatable {
    var title: String?
    var placeholder: String?
    var text: String?
    var isEnabled: Bool
}

struct ButtonState: Equatable {
    var text: String?
    var isEnabled: Bool
}

struct LabelState: Equatable {
    var text: String?
    var isHidden: Bool
}

extension LabelState {
    init(text: String?) {
        self.init(text: text, isHidden: false)
    }
}
