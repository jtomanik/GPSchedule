//
//  LoggedInViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

// sourcery: viewName = "LoggedIn"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "empty(title: "")"
enum LoggedInViewState: BasicViewGenerator, ViewState {

    struct ListDisplayModel: Equatable {
        let title: String?
        let items: [AppointmentComponentState]
    }

    struct DetailDisplayModel: Equatable {

        init() {

        }
    }

    case empty(title: String?)
    case refreshing(title: String?, for: User)
    case list(model: ListDisplayModel, for: User)
    case fetching(id: String, for: User)
    case detail(DetailDisplayModel)

    enum UserAction: AbstractEvent, Equatable {
        case refresh
        case showDetail(id: String)
    }

    // sourcery:inline:auto:LoggedInViewState.AutoInit
        init() {
            self = .empty(title: "")
        }
    // sourcery:end
}

class LoggedInViewModel: GenericChildViewModel<LoggedInViewState, CalendarUseCase, RootViewModel> {

    static func translate(domain model: Appointment) -> AppointmentComponentState {
        // TODO: Create Time formatter
        return AppointmentComponentState(
            id: model.id,
            timeFrom: model.timeSlot?.startDate?.toDate().debugDescription ?? "",
            timeTo: model.timeSlot?.endDate?.toDate().debugDescription ?? "",
            title: model.patient?.person?.display ?? "",
            subtitle: model.appointmentType?.display ?? "")
    }

    static func transform(storeState: CalendarState, state: State) -> State {
        switch storeState {
        case .all(let values, let user):
            if values.isEmpty {
                return .empty(title: user.display)
            } else {
                return .list(model: State.ListDisplayModel(
                                title: user.display,
                                items: values.map { LoggedInViewModel.translate(domain: $0) }),
                             for: user)
            }
        case .detail(let value):
            return state
        case .error:
            return state
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .refresh:
            if case LoggedInViewState.list(_, _, let user) = state {
                return .refreshing(title: user.display, for: user)
            } else {
                return state
            }
        case .showDetail(let id):
            if case LoggedInViewState.list(_, _, let user) = state {
                return .fetching(id: id, for: user)
            } else {
                return state
            }
        }
    }

    override func forwarder(state: LoggedInViewState) {
    }


// sourcery:inline:auto:LoggedInViewModel.AutoInit

// swiftlint:disable all

convenience init(parent: RootViewModel) {

    self.init(parent: parent, transformer: LoggedInViewModel.transform, reducer: LoggedInViewModel.reduce)

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
