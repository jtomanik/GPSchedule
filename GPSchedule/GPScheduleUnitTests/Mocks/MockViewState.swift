//
//  MockViewState.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 24/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation

enum MockViewState: ViewState {

    enum UserAction: AbstractEvent, Equatable {
        case firstAction
        case secondAction
        case thirdAction
    }

    case initial
    case changedByTheUseCase
    case received(actions: [UserAction: Int])

    init() {
        self = .initial
    }
}

extension MockViewState {

    var actions: [UserAction: Int] {
        if case .received(let actions) = self {
            return actions
        } else {
            return [:]
        }
    }
}
