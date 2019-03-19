//
//  ComponentStates.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 17/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

struct AppointmentComponentState: Equatable {
    let id: String
    let timeFrom: String
    let timeTo: String
    let title: String
    let subtitle: String
}
