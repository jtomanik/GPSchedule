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
enum LoginViewState: BasicViewGenerator, ViewState {

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

extension LoginViewState {
    var context: DisplayModel {
        switch self {
        case .inProgress(let displayModel): return displayModel
        case .done(let displayModel): return displayModel
        }
    }
}

class LoginViewModel: GenericChildViewModel<LoginViewState, AuthUseCase, RootViewModel> {

    static func transform(storeState: Store.State, state: State) -> State {
        switch storeState {
        case .unauthorized(let error):
            var newContext = state.context
            newContext.errorMessage.text = error
            newContext.errorMessage.isHidden = error == nil
            return .inProgress(newContext)
        default:
            return state
        }
    }

    static func reduce(state: LoginViewState, action: LoginViewState.UserAction) -> LoginViewState {
        guard case .inProgress(let context) = state else {
            return state
        }

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

        var newContext = context
        switch action {
        case .usernameEntry(let text):
            newContext.usernameField.text = text
            newContext.passwordField.isEnabled = isValid(username: text)
            newContext.loginButton.isEnabled = isValid(state: newContext)
            return .inProgress(newContext)
        case .passwordEntry(let text):
            newContext.passwordField.text = text
            newContext.loginButton.isEnabled = isValid(state: newContext)
            return .inProgress(newContext)
        case .loginButtonPressed:
            if isValid(state: newContext) {
                return .done(newContext)
            } else {
                return .inProgress(newContext)
            }
        }
    }

    override func forwarder(state: LoginViewState) {
        guard case LoginViewState.done(let context) = state else {
            return
        }
        parent?.action.onNext(.bussy)
        store.dispatch(event: .login(
            username: context.usernameField.text!,
            password: context.passwordField.text!))
    }

// sourcery:inline:auto:LoginViewModel.AutoInit
// swiftlint:disable all
convenience init(parent: RootViewModel) {
    self.init(parent: parent, transformer: LoginViewModel.transform, reducer: LoginViewModel.reduce)
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
