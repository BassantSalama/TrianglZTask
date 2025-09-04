//
//  PostsListView.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import SwiftUI

struct PostsListView: View {
    @ObservedObject var viewModel: PostsViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                    Button("Retry") {
                        viewModel.loadPosts(forceRefresh: true)
                    }
                    .padding()
                }
            } else {
                List(viewModel.posts) { post in
                    NavigationLink(destination: PostDetailsView(post: post)) {
                        Text(post.title ?? "No Title")
                    }
                }
                .searchable(text: $viewModel.searchText)
            }
        }
        .navigationTitle("Posts")
    }
}

