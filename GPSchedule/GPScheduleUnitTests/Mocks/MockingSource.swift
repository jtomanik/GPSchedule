//
//  MockingSource.swift
//  GPScheduleUnitTests
//
//  Created by Jakub Tomanik on 24/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

@testable import GPSchedule
import Foundation
import RxSwift

protocol MockService: ServiceCommand {
    static func mockModel(with id: String) -> Self
    func execute() -> Single<MockModel>
}

protocol MockServiceProvider: ServiceProvider {
    associatedtype Service: MockService

    var mockService: Service.Type { get }
}

struct MockModel: DomainModel {
    let id: String
}

struct MockingSource: MockService {

    static func mockModel(with id: String) -> MockingSource {
        return MockingSource(uuid: id)
    }

    private let uuid: String

    private init(uuid: String) {
        self.uuid = uuid
    }

    func execute() -> Single<MockModel> {
        return Observable.just(MockModel(id: uuid)).asSingle()
    }

}
