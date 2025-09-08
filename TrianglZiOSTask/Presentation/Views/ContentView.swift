//
//  ContentView.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel: PostsViewModel

    init(loadPostsUseCase: LoadPostsUseCaseProtocol) {
        _viewModel = StateObject(wrappedValue: PostsViewModel(loadPostsUseCase: loadPostsUseCase))
    }

    var body: some View {
        NavigationStack {
            PostsListView(viewModel: viewModel)
                .onAppear { viewModel.loadPosts() }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mockPosts = [
            Post(id: 1, title: "Mock Post 1", body: "Body of mock post 1"),
            Post(id: 2, title: "Mock Post 2", body: "Body of mock post 2")
        ]
        
        // 2. Mock Use Case
        class MockLoadPostsUseCase: LoadPostsUseCaseProtocol {
            let posts: [Post]
            init(posts: [Post]) { self.posts = posts }
            
            func execute(forceRefresh: Bool = false) -> AnyPublisher<[Post], Error> {
                Just(posts)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }
        
        let mockUseCase = MockLoadPostsUseCase(posts: mockPosts)
        
    
        return ContentView(loadPostsUseCase: mockUseCase)
    }
}









