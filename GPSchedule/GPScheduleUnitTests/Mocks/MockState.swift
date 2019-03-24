//
//  MockState.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 24/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation

enum MockState: DomainState {

    enum StateError: DomainError, Equatable {
        case genericError
    }

    enum StateEvent: DomainEvent, Equatable {
        case first
        case second
        case third
    }

    case initial
    case received(events: [StateEvent: Int])

    init() {
        self = .initial
    }
}

extension MockState {

    var events: [StateEvent: Int] {
        if case .received(let events) = self {
            return events
        } else {
            return [:]
        }
    }
}

enum AnotherMockState: DomainState {

    enum StateError: DomainError, Equatable {
        case genericError
    }

    enum StateEvent: DomainEvent, Equatable {
        case alpha
        case beta
    }

    case initial
    case alpha
    case beta

    init() {
        self = .initial
    }
}
