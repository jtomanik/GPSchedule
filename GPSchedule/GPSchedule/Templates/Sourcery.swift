//
//  Sourcery.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 12/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import OpenMRS

protocol Sourcery {}
protocol BasicViewGenerator: Sourcery {}
protocol DomainImportable: Sourcery {
    var uuid: String? { get }
}

protocol DomainMapable: Sourcery {}

extension String: DomainMapable {}

// sourcery: target = "User"
extension UserGet: DomainImportable {}
