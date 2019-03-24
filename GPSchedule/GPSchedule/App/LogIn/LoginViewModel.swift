//
//  LoginViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxSwiftExt

// sourcery: defaultState = "inProgress(DisplayModel())"
enum LoginViewState: ViewState, BasicViewGenerator {

    struct DisplayModel: Equatable {
        var title: LabelState
        var usernameField: TextInputState
        var passwordField: TextInputState
        var loginButton: ButtonState
        var errorMessage: LabelState

        init() {
            self.title = LabelState(text: "Please log in", isHidden: false)
            self.usernameField = TextInputState(title: "user", placeholder: "username", text: nil, isEnabled: true)
            self.passwordField = TextInputState(title: "pass", placeholder: "password", text: nil, isEnabled: false)
            self.loginButton = ButtonState(text: "login", isEnabled: false)
            self.errorMessage = LabelState(text: nil, isHidden: true)
        }
    }

    enum UserAction: AbstractEvent, Equatable {
        case usernameEntry(String?)
        case passwordEntry(String?)
        case loginButtonPressed
    }

    case inProgress(DisplayModel)
    case done(DisplayModel)

// sourcery:inline:auto:LoginViewState.AutoInit
    init() {
        self = .inProgress(DisplayModel())
    }
// sourcery:end
}

class LoginViewModel: GenericChildViewModel<LoginViewState, AuthUseCase, RootViewModel> {

    static func transform(storeState: Store.State, state: State) -> State {
        switch (storeState, state) {
        case (.unauthorized, _):
            return State.init()
        case (.authFailure, .done(let model)):
            var newModel = model
            newModel.errorMessage.text = "There was an error while logging in"
            newModel.errorMessage.isHidden = false
            return .inProgress(newModel)
        default:
            return state
        }
    }

    static func reduce(state: LoginViewState, action: LoginViewState.UserAction) -> LoginViewState {

        func isValid(state: State.DisplayModel) -> Bool {
            return isValid(username: state.usernameField.text) &&
                isValid(password: state.passwordField.text)
        }

        func isValid(password: String?) -> Bool {
            guard let password = password else {
                return false
            }
            return password.count > 4
        }

        func isValid(username: String?) -> Bool {
            guard let username = username else {
                return false
            }
            return username.count > 4
        }

        switch (state, action) {
        case (.inProgress(let model), .usernameEntry(let text)):
            var newModel = model
            newModel.usernameField.text = text
            newModel.passwordField.isEnabled = isValid(username: text)
            newModel.loginButton.isEnabled = isValid(state: newModel)
            return .inProgress(newModel)
        case (.inProgress(let model), .passwordEntry(let text)):
            var newModel = model
            newModel.passwordField.text = text
            newModel.loginButton.isEnabled = isValid(state: newModel)
            return .inProgress(newModel)
        case (.inProgress(let model), .loginButtonPressed):
            if isValid(state: model) {
                return .done(model)
            } else {
                return .inProgress(model)
            }
        default:
            return state
        }
    }

    static func forward(object: AnyObject?, state: LoginViewState, lastAction: LoginViewState.UserAction) {
        guard let object = object as? LoginViewModel else {
            return
        }

        switch (state, lastAction) {
        case (.inProgress, .loginButtonPressed):
            let parentState = object.parent.state.value
            if case .loading(_) = parentState {
                object.parent.dispatch(action: RootViewState.UserAction.dismissLoading)
            }
        case (.done(let context), .loginButtonPressed):
            // swiftlint:disable force_unwrapping
            object.parent.dispatch(action: .busy)
            object.store.dispatch(event: .login(
                username: context.usernameField.text!,
                password: context.passwordField.text!))
            // swiftlint:enable force_unwrapping
        default:
            return
        }
    }

// sourcery:inline:auto:LoginViewModel.AutoInit
    // swiftlint:disable all
    convenience init(parent: RootViewModel) {
    self.init(
        parent: parent,
        transformer: LoginViewModel.transform,
        reducer: LoginViewModel.reduce,
        forwarder: LoginViewModel.forward)
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
