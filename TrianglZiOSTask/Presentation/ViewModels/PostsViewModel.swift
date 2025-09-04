//
//  PostsViewModel.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Foundation
import Combine

final class PostsViewModel: ObservableObject {
    // Inputs
    @Published var searchText: String = ""
    
    // Outputs
    @Published private(set) var posts: [Post] = []
    @Published private(set) var filteredPosts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let loadPostsUseCase: LoadPostsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(loadPostsUseCase: LoadPostsUseCaseProtocol) {
        self.loadPostsUseCase = loadPostsUseCase
        
        // Reactive search/filter
        Publishers.CombineLatest($searchText, $posts)
            .map { searchText, posts in
                guard !searchText.isEmpty else { return posts }
                return posts.filter { $0.title?.localizedCaseInsensitiveContains(searchText) ?? false }
            }
            .assign(to: &$filteredPosts)
    }
    
    func loadPosts(forceRefresh: Bool = false) {
        isLoading = true
        errorMessage = nil
        
        loadPostsUseCase.execute(forceRefresh: forceRefresh)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}


