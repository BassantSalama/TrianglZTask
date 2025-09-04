//
//  LoadPostsUseCase.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//


import Combine

class LoadPostsUseCase: LoadPostsUseCaseProtocol {
    private let repository: PostsRepositoryProtocol

    init(repository: PostsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(forceRefresh: Bool = false) -> AnyPublisher<[Post], Error> {
        return repository.fetchPosts(forceRefresh: forceRefresh)
    }
}

