//
//  GenericTableViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 14/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Bento
import BentoKit

class GenericTableViewController<VM: ViewReactor>: GenericViewController<VM> {

    lazy var tableView: BentoTableView = {
        let table = BentoTableView()
        return table
    }()

    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
    }
}
