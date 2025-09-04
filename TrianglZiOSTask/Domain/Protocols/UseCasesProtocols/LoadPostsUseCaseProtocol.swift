//
//  LoadPostsUseCaseProtocol.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Combine

protocol LoadPostsUseCaseProtocol {
    func execute(forceRefresh: Bool) -> AnyPublisher<[Post], Error>
}
