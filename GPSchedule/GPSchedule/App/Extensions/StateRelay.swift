//
//  StateRelay.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 20/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import RxSwift

// StateRelay is a wrapper for `BehaviorSubject`.
// Unlike `BehaviorSubject` it can't terminate with error or completed.
// This was created to avoid importing RxCocoa just for BehaviorSubject
// swiftlint:disable all
final class StateRelay<Element: AbstractState>: ObservableType {

    typealias E = Element

    private let subject: BehaviorSubject<Element>

    func accept(_ event: Element) {
        self.subject.onNext(event)
    }

    var value: Element {
        // this try! is ok because subject can't error out or be disposed
        return try! self.subject.value()
    }

    init(value: Element) {
        self.subject = BehaviorSubject(value: value)
    }

    func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return self.subject.subscribe(observer)
    }

    func asObservable() -> Observable<Element> {
        return self.subject.asObservable()
    }
}
// swiftlint:enable all
