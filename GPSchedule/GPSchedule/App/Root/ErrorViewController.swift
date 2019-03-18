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
enum ErrorViewState: BasicViewGenerator, ViewState {
    case none

    enum UserAction: AbstractEvent, Equatable {
    }

// sourcery:inline:auto:ErrorViewState.AutoInit
    init() {
        self = .none
    }
// sourcery:end
}

class ErrorViewModel: GenericChildViewModel<ErrorViewState, RootUseCase, RootViewModel> {

    static func transform(storeState: RootState, state: State) -> State {
        return state
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        return state
    }

// sourcery:inline:auto:ErrorViewModel.AutoInit
// swiftlint:disable all
convenience init(parent: RootViewModel) {
    self.init(parent: parent, transformer: ErrorViewModel.transform, reducer: ErrorViewModel.reduce)
}

required convenience init(parent: Parent, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
    self.init(warehouse: parent.warehouse, transformer: transformer, reducer: reducer)
    self.parent = parent
}

required init(warehouse: DomainStoreFacade, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
    super.init(warehouse: warehouse, transformer: transformer, reducer: reducer)
}
// swiftlint:enable all
// sourcery:end
}

class ErrorViewController: GenericViewController<ErrorViewModel> {

    override func setupView() {
        self.view.backgroundColor = UIColor.black
    }

    override func process(state: ErrorViewModel.State) {
        return
    }
}
