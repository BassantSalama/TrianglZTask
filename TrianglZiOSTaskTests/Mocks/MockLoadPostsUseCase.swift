//
//  MockLoadPostsUseCase.swift
//  TrianglZiOSTaskTests
//
//  Created by mac on 07/09/2025.
//

import Foundation
import Combine
@testable import TrianglZiOSTask

// Mock UseCase for testing ViewModel in isolation
class MockLoadPostsUseCase: LoadPostsUseCaseProtocol {
    var postsToReturn: [Post] = []
    var shouldFail: Bool = false

    func execute(forceRefresh: Bool) -> AnyPublisher<[Post], Error> {
        if shouldFail {
            return Fail(error: NSError(domain: "MockError", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        } else {
            return Just(postsToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
