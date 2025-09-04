//
//  Post.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String?
    let body: String?
}
