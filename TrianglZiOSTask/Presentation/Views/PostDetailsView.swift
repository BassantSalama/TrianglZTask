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
            Text(post.body ?? "No Body")
                .padding()
        }
        .navigationTitle("Detail")
    }
}

