//
//  PostsRepositoryImpl.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Combine

class PostsRepositoryImpl: PostsRepositoryProtocol {
    let remote: RemotePostsAPI
    let local: LocalPostsCache

    init(remote: RemotePostsAPI, local: LocalPostsCache) {
        self.remote = remote
        self.local = local
    }

    func fetchPosts(forceRefresh: Bool) -> AnyPublisher<[Post], Error> {
        if !forceRefresh {
            return local.loadPublisher()
                .mapError { $0 as Error }
                .flatMap { cachedPosts -> AnyPublisher<[Post], Error> in
                    if !cachedPosts.isEmpty {
                        return Just(cachedPosts)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    } else {
                        return self.fetchFromNetwork()
                    }
                }
                .eraseToAnyPublisher()
        } else {
            return fetchFromNetwork()
        }
    }

    private func fetchFromNetwork() -> AnyPublisher<[Post], Error> {
        return remote.fetchPosts()
            .flatMap { [weak self] posts -> AnyPublisher<[Post], Error> in
                guard let self = self else { return Just(posts).setFailureType(to: Error.self).eraseToAnyPublisher() }
                
                return self.local.savePublisher(posts)
                    .map { posts }
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
