//
//  PostsRepositoryProtocol.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Combine

protocol PostsRepositoryProtocol {
    func fetchPosts(forceRefresh: Bool) -> AnyPublisher<[Post], Error>
}
