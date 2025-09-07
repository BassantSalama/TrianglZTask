

import XCTest
import Combine
@testable import TrianglZiOSTask

final class LoadPostsUseCaseTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testLoadPostsUseCase_success() {
        // Arrange
        let mockPosts = [Post(id: 1, title: "Test", body: "Body")]
        let repository = MockPostsRepository(posts: mockPosts)
        let useCase = LoadPostsUseCase(repository: repository)
        let expectation = XCTestExpectation(description: "Fetch posts successfully")
        
        // Act
        useCase.execute(forceRefresh: false)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { posts in
                    // Assert
                    XCTAssertEqual(posts.count, 1)
                    XCTAssertEqual(posts.first?.title, "Test")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
