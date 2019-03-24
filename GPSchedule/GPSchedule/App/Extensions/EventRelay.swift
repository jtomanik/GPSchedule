//
//  EventRelay.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 20/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import RxSwift

// EventRelay is a wrapper for `PublishSubject`.
// Unlike `PublishSubject` it can't terminate with error or completed.
// This was created to avoid importing RxCocoa just for PublishSubject
// swiftlint:disable all
final class EventRelay<Element: AbstractEvent>: ObservableType {

    typealias E = Element

    private let subject: PublishSubject<Element>

    func accept(_ event: Element) {
        self.subject.onNext(event)
    }

    init() {
        self.subject = PublishSubject()
    }

    func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return self.subject.subscribe(observer)
    }

    func asObservable() -> Observable<Element> {
        return self.subject.asObservable()
    }
}
// swiftlint:enable all
