//
//  RootViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 10/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxSwiftExt

// sourcery: defaultState = "logIn"
enum RootViewState: ViewState {
    case logIn
    case loggedIn
    case loading
    case error(DomainError)

    enum UserAction: Event {
        case bussy
        // case dissmissError
    }

    init() {
        self = .logIn
    }
}

class RootViewModel: GenericViewModel<RootViewState, RootUseCase> {

    static func transform(storeState: RootState, state: State) -> State {
        switch storeState {
        case .unauthorized:
            return .logIn
        case .authorized:
            return .loggedIn
        case .error(let error):
            return .error(error)
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .bussy:
            return .loading
        }
    }

// sourcery:inline:auto:RootViewModel.AutoInit
// swiftlint:disable all
convenience init(store: RootUseCase) {
    self.init(store: store, transformer: RootViewModel.transform, reducer: RootViewModel.reduce)
}

required init(store: Store, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
    super.init(store: store, transformer: transformer, reducer: reducer)
}
// swiftlint:enable all
// sourcery:end
}
