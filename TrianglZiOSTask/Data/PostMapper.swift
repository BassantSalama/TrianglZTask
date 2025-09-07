//
//  PostMapper.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Foundation
import CoreData

extension PostEntity {
    func toDomain() -> Post {
        return Post(
            id: Int(self.id),
            title: self.title,
            body: self.body
        )
    }

    func fromDomain(_ post: Post) {
        self.id = Int32(post.id)
        self.title = post.title
        self.body = post.body
    }
}
