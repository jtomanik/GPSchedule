//
//  ErrorViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

// sourcery: viewName = "Error"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "none"
enum ErrorViewState: BasicViewGenerator {
    case none

    enum UserAction: Event, Equatable {
    }
}

extension ErrorViewState: ViewState {
    init() {
        self = .none
    }
}

class ErrorViewModel: GenericChildViewModel<ErrorViewState, RootViewModel> {
    
    convenience init(parent: RootViewModel) {
        self.init(parent: parent, transformer: nil, reducer: nil)
    }

    required convenience init(parent: Parent, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
        self.init(store: parent.store, transformer: transformer, reducer: reducer)
        self.parent = parent
    }

    required init(store: Store, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
        super.init(store: store, transformer: transformer, reducer: reducer)
    }
}

class ErrorViewController: GenericViewController<ErrorViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.black
    }

    override func process(state: ErrorViewModel.State) {
        return
    }
}
