//
//  CalendarViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

// sourcery: viewName = "LoggedIn"
// sourcery: parentViewModel = "RootViewModel"
// sourcery: defaultState = "empty(title: "")"
enum CalendarViewState: BasicViewGenerator, ViewState {

    struct ListDisplayModel: Equatable {
        let title: String?
        let items: [AppointmentComponentState]
    }

    struct DetailDisplayModel: Equatable {
        let title: LabelState
        let brief: LabelState
        let timeslotText: LabelState
        let startDate: LabelState
        let endDate: LabelState
        let appointmenText: LabelState
        let reason: LabelState
    }

    case empty(title: String?)
    case refreshing(title: String?, for: User)
    case list(model: ListDisplayModel, for: User)
    case fetching(id: String, for: User)
    case detail(DetailDisplayModel, for: User)

    enum UserAction: AbstractEvent, Equatable {
        case refresh
        case showDetail(id: String)
    }

    // sourcery:inline:auto:CalendarViewState.AutoInit
        init() {
            self = .empty(title: "")
        }
    // sourcery:end
}

extension CalendarViewState.DetailDisplayModel {

    init() {
        self.init(title: LabelState(text: nil),
                  brief: LabelState(text: nil),
                  timeslotText: LabelState(text: nil),
                  startDate: LabelState(text: nil),
                  endDate: LabelState(text: nil),
                  appointmenText: LabelState(text: nil),
                  reason: LabelState(text: nil))
    }
}

class CalendarViewModel: GenericChildViewModel<CalendarViewState, CalendarUseCase, RootViewModel> {

    static func translate(short model: Appointment) -> AppointmentComponentState {
        return AppointmentComponentState(
            id: model.id,
            timeFrom: TimeFormatter.shared.from(date: model.timeSlot?.startDate?.toDate()),
            timeTo: TimeFormatter.shared.from(date: model.timeSlot?.endDate?.toDate()),
            title: model.patient?.person?.display ?? "",
            subtitle: model.appointmentType?.display ?? "")
    }

    static func translate(full model: Appointment) -> CalendarViewState.DetailDisplayModel {
        return CalendarViewState.DetailDisplayModel.init(
            title: LabelState(text: model.patient?.display),
            brief: LabelState(text: model.display),
            timeslotText: LabelState(text: model.timeSlot?.display),
            startDate: LabelState(text: TimeFormatter.shared.from(date: model.timeSlot?.startDate?.toDate())),
            endDate: LabelState(text: TimeFormatter.shared.from(date: model.timeSlot?.endDate?.toDate())),
            appointmenText: LabelState(text: model.appointmentType?.display),
            reason: LabelState(text: model.reason))
    }

    static func transform(storeState: CalendarState, state: State) -> State {
        switch storeState {
        case .all(let values, let user):
            if values.isEmpty {
                return .empty(title: user.display)
            } else {
                return .list(model: State.ListDisplayModel(
                    title: user.display,
                    items: values.map { CalendarViewModel.translate(short: $0) }),
                             for: user)
            }
        case .detail(let item, let user):
            return .detail(CalendarViewModel.translate(full: item), for: user)
        case .error:
            return state
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch action {
        case .refresh:
            if case CalendarViewState.list(_, let user) = state {
                return .refreshing(title: user.display, for: user)
            } else if case CalendarViewState.detail(_, let user) = state {
                return .refreshing(title: user.display, for: user)
            } else {
                return state
            }
        case .showDetail(let id):
            if case CalendarViewState.list(_, let user) = state {
                return .fetching(id: id, for: user)
            } else {
                return state
            }
        }
    }

    override func forwarder(state: CalendarViewState) {
        switch state {
        case .refreshing(_, let user):
            store.dispatch(event: CalendarState.StateEvent.fetchAll(for: user))
        case .fetching(let id, let user):
            store.dispatch(event: CalendarState.StateEvent.fetchDetail(id: id, for: user))
        default:
            return
        }
    }


// sourcery:inline:auto:CalendarViewModel.AutoInit

// swiftlint:disable all

convenience init(parent: RootViewModel) {

    self.init(parent: parent, transformer: CalendarViewModel.transform, reducer: CalendarViewModel.reduce)

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
