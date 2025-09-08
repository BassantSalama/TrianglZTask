//
//  PostDetailsView.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import SwiftUI

struct PostDetailsView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let title = post.title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                
                Text(post.body ?? "No Body")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}





