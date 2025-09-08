//
//  TrianglZiOSTaskApp.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import SwiftUI

@main
struct TrianglZiOSTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        let local = LocalPostsCache(context: persistenceController.container.viewContext)
        let remote = RemotePostsAPI()
        let repository = PostsRepositoryImpl(remote: remote, local: local)
        let useCase = LoadPostsUseCase(repository: repository)

        WindowGroup {
            ContentView(loadPostsUseCase: useCase)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
