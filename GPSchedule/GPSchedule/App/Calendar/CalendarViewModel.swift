//
//  CalendarViewModel.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 13/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation

// sourcery: defaultState = "empty(title: "")"
enum CalendarViewState: ViewState, BasicViewGenerator {

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

    enum UserAction: AbstractEvent, Equatable {
        case refresh
        case showList
        case showDetail(id: String)
    }

    case empty(title: String?)
    case refreshing(title: String?, for: User)
    case list(model: ListDisplayModel, for: User, timestamp: Double)
    case fetching(id: String, for: User)
    case detail(DetailDisplayModel, for: User, timestamp: Double)

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
            timeFrom: DateTimeFormatter.shared.from(date: model.timeSlot?.appointmentBlock?.startDate),
            timeTo: HourlyFormatter.shared.from(date: model.timeSlot?.appointmentBlock?.endDate),
            title: model.patient?.person?.display ?? "",
            subtitle: model.appointmentType?.display ?? "")
    }

    static func translate(full model: Appointment) -> CalendarViewState.DetailDisplayModel {
        return CalendarViewState.DetailDisplayModel.init(
            title: LabelState(text: model.patient?.person?.display),
            brief: LabelState(text: model.appointmentType?.display),
            timeslotText: LabelState(text: model.timeSlot?.display),
            startDate: LabelState(text: HourlyFormatter.shared.from(date: model.timeSlot?.appointmentBlock?.startDate)),
            endDate: LabelState(text: HourlyFormatter.shared.from(date: model.timeSlot?.appointmentBlock?.endDate)),
            appointmenText: LabelState(text: model.display),
            reason: LabelState(text: model.reason))
    }

    static func transform(storeState: CalendarState, state: State) -> State {
        switch (storeState, state) {
        case (.all(let values, let user, _), _):
            let title = user.person?.display
            if values.isEmpty {
                return .empty(title: title)
            } else {
                return .list(model: State.ListDisplayModel(
                    title: title,
                    items: values.map { CalendarViewModel.translate(short: $0) }),
                             for: user,
                    timestamp: Date.timestamp)
            }
        case (.detail(let item, _, let user), _):
            return .detail(CalendarViewModel.translate(full: item),
                           for: user,
                           timestamp: Date.timestamp)
        case (.error, _):
            return state
        }
    }

    static func reduce(state: State, action: State.UserAction) -> State {
        switch (state, action) {
        case (.list(_, let user, _), .refresh):
            return .refreshing(title: user.display, for: user)
        case (.detail(_, let user, _), .refresh):
            return .refreshing(title: user.display, for: user)
        case (.list(_, let user, _), .showDetail(let id)):
            return .fetching(id: id, for: user)
        case (.detail(_, let user, _), .showList):
            return .list(model: CalendarViewState.ListDisplayModel(title: user.display, items: []),
                         for: user,
                         timestamp: Date.timestamp)
        default:
            return state
        }
    }

    static func forward(object: AnyObject?, state: CalendarViewState, lastAction: CalendarViewState.UserAction) {
        guard let object = object as? CalendarViewModel else {
            return
        }

        switch (state, lastAction) {
        case (.refreshing(_, let user), _):
            object.store.dispatch(event: CalendarState.StateEvent.fetchAll(for: user))
        case (.fetching(let id, let user), _):
            object.store.dispatch(event: CalendarState.StateEvent.fetchDetail(id: id, for: user))
        case (.list, .showList):
            object.store.dispatch(event: CalendarState.StateEvent.rollback)
        default:
            return
        }
    }

// sourcery:inline:auto:CalendarViewModel.AutoInit
    // swiftlint:disable all
    convenience init(parent: RootViewModel) {
    self.init(
        parent: parent,
        transformer: CalendarViewModel.transform,
        reducer: CalendarViewModel.reduce,
        forwarder: CalendarViewModel.forward)
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
