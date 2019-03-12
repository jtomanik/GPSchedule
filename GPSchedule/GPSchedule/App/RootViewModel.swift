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

    init(){
        self = .logIn
    }
}

class RootViewModel: GenericViewModel<RootViewState, RootStore> {

    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .bussy:
            return .loading
        }
    }

    static func transform(storeState: RootState, state: State) -> State {
        switch storeState.rootState {
        case .unauthorized:
            return .logIn
        case .authorized:
            return .loggedIn
        case .error(let error):
            return .error(error)
        }
    }

    convenience init(store: RootStore) {
        self.init(store: store, transformer: RootViewModel.transform, reducer: RootViewModel.reduce)
    }

    required init(store: Store, transformer: ViewStateTransformer<Store.State, State>?, reducer: ViewStateReducer<State>?) {
        super.init(store: store, transformer: transformer, reducer: reducer)
    }
}
