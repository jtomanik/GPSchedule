//
//  TimeFormatter.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 19/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

class TimeFormatter: DateFormatter {

    static let shared: TimeFormatter = {
        let instance = TimeFormatter()
        instance.locale = Locale(identifier: "en_US_POSIX")
        instance.dateFormat = "HH:mm"
        return instance
    }()

    private override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func from(date: Date?) -> String {
        guard let date = date else {
            return ""
        }

        let result = self.string(from: date)
        return result
    }
}
