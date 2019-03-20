//
//  GenericComponent.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 12/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import UIKit
import Bento

class GenericComponent<S, V: NativeView>: NSObject, Renderable {

    typealias View = V

    let state: S

    init(state: S) {
        self.state = state
    }

    func render(in view: View) {
    }
}

class GenericActionableComponent<S, R, V: NativeView>: GenericComponent<S, V> {

    let didUpdate: ((R) -> Void)?

    init(state: S, didUpdate: @escaping (R) -> Void) {
        self.didUpdate = didUpdate
        super.init(state: state)
    }
}
