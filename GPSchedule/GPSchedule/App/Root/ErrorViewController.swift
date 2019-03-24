//
//  ErrorViewController.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 08/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Cartography

enum ErrorViewState: BasicViewGenerator, ViewState {

    struct DisplayModel: Equatable {
        let closeTitle: String?
        let message: String?
    }

    enum UserAction: AbstractEvent, Equatable {
        case close
    }

    case showing(DisplayModel)
    case hiding(TimeInterval)

    init() {
        self = .showing(DisplayModel(closeTitle: nil, message: nil))
    }
}

class ErrorViewModel: GenericChildViewModel<ErrorViewState, RootUseCase, RootViewModel> {

    static func transform(storeState: RootState, state: State) -> State {
        if case RootState.error = storeState {
            return .showing(ErrorViewState.DisplayModel(closeTitle: "close", message: "There was an error"))
        } else {
            return state
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        return .hiding(Date().timeIntervalSinceReferenceDate)
    }

    static func forward(object: AnyObject?, state: ErrorViewState, action: ErrorViewState.UserAction) {
        guard let object = object as? ErrorViewModel else {
            return
        }
        if case .hiding = state {
            object.parent.dispatch(action: RootViewState.UserAction.dismissError)
        }
    }

// sourcery:inline:auto:ErrorViewModel.AutoInit
    // swiftlint:disable all
    convenience init(parent: RootViewModel) {
    self.init(
        parent: parent,
        transformer: ErrorViewModel.transform,
        reducer: ErrorViewModel.reduce,
        forwarder: ErrorViewModel.forward)
    }

    required convenience init(
        parent: Parent,
        transformer: ViewStateTransformer<Store.State, State>?,
        reducer: ViewStateReducer<State>?,
        forwarder: ViewStateForwarder<State>?) {
        self.init(
            initialState: State.init(),
            warehouse: parent.warehouse,
            transformer: transformer,
            reducer: reducer,
            forwarder: forwarder)
        self.parent = parent
    }

    required init(
        initialState: State,
        warehouse: DomainStoreFacade,
        transformer: ViewStateTransformer<Store.State, State>?,
        reducer: ViewStateReducer<State>?,
        forwarder: ViewStateForwarder<State>?) {
        super.init(
            warehouse: warehouse,
            transformer: transformer,
            reducer: reducer,
            forwarder: forwarder)
    }
    // swiftlint:enable all
// sourcery:end
}

class ErrorViewController: GenericViewController<ErrorViewModel> {

    lazy var errorLabel: UILabel = {
        let view = UILabel()
        return view
    }()

    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.black, for: .normal)
        view.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return view
    }()

    override func setupView() {
        // swiftlint:disable force_unwrapping
        self.view.addSubview(errorLabel)
        constrain(errorLabel) { view in
            view.center == view.superview!.center
        }
        self.view.addSubview(closeButton)
        constrain(closeButton) { view in
            view.top == view.superview!.safeAreaLayoutGuide.top + 20
            view.right == view.superview!.safeAreaLayoutGuide.right - 60
        }
        // swiftlint:enable force_unwrapping
    }

    override func process(state: ErrorViewModel.State) {
        if case .showing(let model) = state {
            errorLabel.text = model.message
            closeButton.setTitle(model.closeTitle, for: .normal)
        }
    }

    @objc
    private func closeButtonTapped() {
        viewModel.dispatch(action: ErrorViewState.UserAction.close)
    }
}
