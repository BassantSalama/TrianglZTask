//
//  RemotePostsAPI.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Foundation
import Combine

class RemotePostsAPI {
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
