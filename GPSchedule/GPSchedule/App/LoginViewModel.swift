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

// sourcery: store = "RootStore"
// sourcery: parent = "RootViewModel"
class LoginViewModel: ChildViewReactor {

    // sourcery: defaultState = "logIn"
    struct State: ViewState {
        var usernameField: TextFieldState
        var passwordField: TextFieldState
        var loginButton: ButtonState
        var errorMessage: LabelState

        enum UserAction {
            case usernameEntry(String?)
            case passwordEntry(String?)
            case loginButtonPressed
        }

        init() {
            self.usernameField = TextFieldState(placeholder: nil, text: nil, isEnabled: true)
            self.passwordField = TextFieldState(placeholder: nil, text: nil, isEnabled: false)
            self.loginButton = ButtonState(text: nil, isEnabled: false)
            self.errorMessage = LabelState(text: nil, isHidden: true)
        }
    }

    // sourcery:inline:LoginViewModel.ViewReactor
    weak var parent: RootViewModel?
    let store: RootStore
    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State())
    
    required init(store: RootStore) {
        self.store = store
    }

    // sourcery:end
}

extension LoginViewModel: ViewStateReducer {
    func reduce(state: State, action: State.UserAction) -> State {
        var newState = state
        switch action {
        case .usernameEntry(let text):
            newState.usernameField.text = text
            newState.passwordField.isEnabled = isValid(username: text)
            newState.loginButton.isEnabled = isValid(state: newState)
        case .passwordEntry(let text):
            newState.passwordField.text = text
            newState.loginButton.isEnabled = isValid(state: newState)
        case .loginButtonPressed:
            if isValid(state: newState) {
                parent?.action.onNext(.bussy)
                store.dispatch(event: .login(
                    username: newState.usernameField.text!,
                    password: newState.passwordField.text!))
            }
        }
        return newState
    }

    private func isValid(state: State) -> Bool {
        return isValid(username: state.usernameField.text) &&
            isValid(password: state.passwordField.text)
    }

    private func isValid(password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        return password.count > 4
    }

    private func isValid(username: String?) -> Bool {
        guard let username = username else {
            return false
        }
        return username.count > 4
    }
}

extension LoginViewModel: ViewStateTransformer {
    func transform(storeState: Store.State, state: State) -> State {
        switch storeState.rootState {
        case .unauthorized(let error):
            var newState = state
            newState.errorMessage.text = error
            newState.errorMessage.isHidden = error == nil
            return newState
        default:
            return state
        }
    }
}
