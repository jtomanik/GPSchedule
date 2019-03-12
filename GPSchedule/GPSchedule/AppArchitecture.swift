//
//  AppArchitecture.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 09/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Abstract declarations
/*
 responsibility: 
*/
protocol Event {}

protocol DomainState: Equatable {
    associatedtype DomainEvent: Event
}

protocol DomaninStateReducer {
    associatedtype State: DomainState
    func reduce(state: State, event: State.DomainEvent) -> State
}

protocol DomainStateFeedbackLoop {
    associatedtype State: DomainState
    func feedback(state: Observable<State>) -> Observable<State.DomainEvent>
}

protocol DomainStateStore: class {
    associatedtype State: DomainState
    associatedtype Reducer: DomaninStateReducer

    var state: BehaviorSubject<State> { get }

    init(initialState: State, reducer: Reducer)
    func dispatch(event: State.DomainEvent)
}

protocol ViewState: Equatable {
    associatedtype UserAction: Event

    init()
}

protocol ViewStateTransformer {
    static func transform<StoreState: DomainState, State: ViewState>(storeState: StoreState, state: State) -> State
}

protocol ViewStateReducer {
    static func reduce<State: ViewState>(state: State, action: State.UserAction) -> State
}

protocol ViewReactor: class, ViewStateReducer, ViewStateTransformer {
    associatedtype State: ViewState
    associatedtype Store: DomainStateStore

    var store: Store! { get }
    var action: PublishSubject<State.UserAction> { get }
    var state: BehaviorSubject<State> { get }

    init(store: Store)
}

protocol ChildViewReactor: ViewReactor {
    associatedtype Parent: ViewReactor where Parent.Store == Store

    init(parent: Parent)
}

protocol AppView: class {
    associatedtype ViewModel: ViewReactor

//    var viewModel: ViewModel { get }
    init(viewModel: ViewModel)
}


// MARK: Implementations
import UIKit

protocol AppError: Error {} // make it comparable?

extension ViewStateTransformer {
    static func transform<StoreState, State>(storeState: StoreState, state: State) -> State
        where StoreState: DomainState, State: ViewState {
            return state
    }
}

extension ViewStateReducer {
    static func reduce<State>(state: State, action: State.UserAction) -> State
        where State: ViewState {
            return state
    }
}

class GenericViewModel<VS: ViewState, ST: DomainStateStore>: ViewReactor, ViewStateTransformer, ViewStateReducer {

    typealias State = VS
    typealias Store = ST

    weak var store: Store!
    let action = PublishSubject<State.UserAction>()
    let state = BehaviorSubject<State>(value: State.init())
    private let disposableBag = DisposeBag()

    required init(store: Store) {
        self.store = store

        store.state
            .distinctUntilChanged()
            .map { [state] in try type(of: self).transform(storeState: $0, state: state.value()) }
            .bind(to: state)
            .disposed(by: disposableBag)

        action
            .map { [state] in try type(of: self).reduce(state: state.value(), action: $0) }
            .bind(to: state)
            .disposed(by: disposableBag)

        state
            .distinctUntilChanged()
            .subscribeNext(weak: self, type(of: self).forwarder)
            .disposed(by: disposableBag)
    }

    func forwarder<S: ViewState>(state: S) {
        return
    }
}

class GenericChildViewModel<VS: ViewState, PT: ViewReactor>: GenericViewModel<VS, PT.Store>, ChildViewReactor {

    typealias State = VS
    typealias Store = PT.Store
    typealias Parent = GenericViewModel<PT.State, Store>

    weak var parent:  Parent!

    required init(parent: Parent) {
        super.init(store: parent.store)
        self.parent = parent
    }

    // TODO: Think how we can get rid of this initializator
    required init(store: Store) {
        fatalError("Child ViewModel must be initialized with a parent")
    }
}

class GenericViewController<VM: ViewReactor>: UIViewController, AppView {

    typealias ViewModel = VM

    private(set) var viewModel: ViewModel
    private(set) var disposeBag = DisposeBag()

    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindToViewModel()
    }

    func setupView() {
        return
    }

    func bindToViewModel() {
        viewModel.state
            .subscribe(
                weak: self,
                onNext: { return $0.process },
                onError: { (_) -> (Error) -> Void in fatalError("Unhandled error has occured") },
                onCompleted: { (_) -> () -> Void in fatalError("Root state must not compleate while application is running") },
                onDisposed: { (_) -> () -> Void in fatalError("Root state must not be disposed while application is running") })
            .disposed(by: disposeBag)
    }

    func process(state: ViewModel.State) {
        return
    }
}
