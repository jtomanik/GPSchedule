//
//  Date+timestamp.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 21/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

extension Date {
    static var timestamp: Double {
        return Date().timeIntervalSince1970
    }
}
