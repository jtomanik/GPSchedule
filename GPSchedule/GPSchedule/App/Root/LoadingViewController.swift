//
//  LoadingViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Cartography

// sourcery: viewName = "Loading"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "animating"
enum LoadingViewState: BasicViewGenerator, ViewState {
    case stopped
    case animating

    enum UserAction: AbstractEvent, Equatable {
    }

// sourcery:inline:auto:LoadingViewState.AutoInit
    init() {
        self = .animating
    }
// sourcery:end
}

class LoadingViewModel: GenericChildViewModel<LoadingViewState, RootUseCase, RootViewModel> {

    static func transform(storeState: RootState, state: State) -> State {
        return state
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        return state
    }

// sourcery:inline:auto:LoadingViewModel.AutoInit
// swiftlint:disable all
convenience init(parent: RootViewModel) {
    self.init(parent: parent, transformer: LoadingViewModel.transform, reducer: LoadingViewModel.reduce)
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

class LoadingViewController: GenericViewController<LoadingViewModel> {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()

    override func setupView() {
        self.view.addSubview(activityIndicator)
        constrain(activityIndicator) { view in
            view.center == view.superview!.center
        }
        activityIndicator.style = .gray
    }

    override func process(state: LoadingViewModel.State) {
        switch state {
        case .stopped:
            activityIndicator.stopAnimating()
        case .animating:
            activityIndicator.startAnimating()
        }
    }
}
