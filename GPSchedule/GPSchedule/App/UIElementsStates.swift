//
//  UIElementsStates.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

//protocol UIKitAutoState {}
//
//protocol ViewAutoState: UIKitAutoState {
//    var isHidden: Bool { get set }
//}
//
//protocol ControlAutoState: ViewAutoState {
//    var isEnabled: Bool { get set }
//}


struct TextFieldState: Equatable {
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
