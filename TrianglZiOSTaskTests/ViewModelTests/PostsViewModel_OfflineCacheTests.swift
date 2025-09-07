//
//  PostsViewModel_OfflineCacheTests.swift
//  TrianglZiOSTaskTests
//
//  Created by mac on 07/09/2025.
//

import XCTest
import Combine
@testable import TrianglZiOSTask

final class PostsViewModel_OfflineCacheTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testViewModel_offlineCache() {
        let cachedPosts = [Post(id: 1, title: "Cached Post", body: "Cached body")]
        let remotePosts = [Post(id: 2, title: "Remote Post", body: "Remote body")]
        
        // forceRefresh = false → should return cached
        let mockUseCase1 = MockLoadPostsUseCase()
        mockUseCase1.postsToReturn = cachedPosts
        let viewModel1 = PostsViewModel(loadPostsUseCase: mockUseCase1)
        let expectation1 = XCTestExpectation(description: "Returns cached posts")
        
        viewModel1.$posts
            .dropFirst()
            .sink { posts in
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts.first?.title, "Cached Post")
                expectation1.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel1.loadPosts(forceRefresh: false)
        
        // forceRefresh = true → should return remote
        let mockUseCase2 = MockLoadPostsUseCase()
        mockUseCase2.postsToReturn = remotePosts
        let viewModel2 = PostsViewModel(loadPostsUseCase: mockUseCase2)
        let expectation2 = XCTestExpectation(description: "Returns remote posts on force refresh")
        
        viewModel2.$posts
            .dropFirst()
            .sink { posts in
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts.first?.title, "Remote Post")
                expectation2.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel2.loadPosts(forceRefresh: true)
        
        wait(for: [expectation1, expectation2], timeout: 2)
    }
}
