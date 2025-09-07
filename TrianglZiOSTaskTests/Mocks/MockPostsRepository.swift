//
//  MockPostsRepository.swift
//  TrianglZiOSTaskTests
//
//  Created by mac on 07/09/2025.
//

import Foundation
import Combine
@testable import TrianglZiOSTask

class MockPostsRepository: PostsRepositoryProtocol {
    private let posts: [Post]
    private let shouldFail: Bool

    init(posts: [Post] = [], shouldFail: Bool = false) {
        self.posts = posts
        self.shouldFail = shouldFail
    }

    func fetchPosts(forceRefresh: Bool = false) -> AnyPublisher<[Post], Error> {
        if shouldFail {
            return Fail(error: NSError(domain: "MockError", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        } else {
            return Just(posts)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
