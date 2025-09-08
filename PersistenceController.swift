//
//  NSPersistentContainer.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TrianglZiOSTask")
        
        if inMemory {
            // Use in-memory store for testing purposes
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("❌ Failed to load persistent store: \(error), \(error.userInfo)")
            } else {
                print("✅ Persistent store loaded at: \(description.url?.absoluteString ?? "Unknown URL")")
            }
        }
        
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
