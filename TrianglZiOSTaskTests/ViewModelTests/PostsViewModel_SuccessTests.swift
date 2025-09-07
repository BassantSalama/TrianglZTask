//
//  PostsViewModel_SuccessTests.swift
//  TrianglZiOSTaskTests
//
//  Created by mac on 07/09/2025.
//

import XCTest
import Combine
@testable import TrianglZiOSTask

final class PostsViewModel_SuccessTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testViewModel_loadPosts_success() {
        let mockPosts = [
            Post(id: 1, title: "Test 1", body: "Body 1"),
            Post(id: 2, title: "Test 2", body: "Body 2")
        ]

        let mockUseCase = MockLoadPostsUseCase()
        mockUseCase.postsToReturn = mockPosts

        let viewModel = PostsViewModel(loadPostsUseCase: mockUseCase)
        let expectation = XCTestExpectation(description: "ViewModel loads posts successfully")

        viewModel.$posts
            .dropFirst()
            .sink { posts in
                XCTAssertEqual(posts.count, 2)
                XCTAssertEqual(posts.first?.title, "Test 1")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadPosts()
        wait(for: [expectation], timeout: 1)
    }
}
