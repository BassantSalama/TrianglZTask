//
//  TrianglZiOSTaskApp.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import SwiftUI

@main
struct TrianglZTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        let local = LocalPostsCache(context: persistenceController.container.viewContext)
        let remote = RemotePostsAPI()
        let repository = PostsRepositoryImpl(remote: remote, local: local)
        let useCase = LoadPostsUseCase(repository: repository)

        return WindowGroup {
            ContentView(loadPostsUseCase: useCase)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}



