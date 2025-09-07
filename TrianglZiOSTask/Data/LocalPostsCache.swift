//
//  LocalPostsCache.swift
//  TrianglZiOSTask
//
//  Created by mac on 04/09/2025.
//

import CoreData
import Combine

enum CacheError: Error {
    case fetchFailed(Error)
    case saveFailed(Error)
}

class LocalPostsCache {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func loadPublisher() -> AnyPublisher<[Post], CacheError> {
        Future { [weak self] promise in
            guard let self = self else { return }
            let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
            do {
                let entities = try self.context.fetch(request)
                promise(.success(entities.map { $0.toDomain() }))
            } catch {
                promise(.failure(.fetchFailed(error)))
            }
        }
        .eraseToAnyPublisher()
    }

    func savePublisher(_ posts: [Post]) -> AnyPublisher<Void, CacheError> {
        Future { [weak self] promise in
            guard let self = self else { return }
            posts.forEach { post in
                let entity = PostEntity(context: self.context)
                entity.fromDomain(post)
            }
            do {
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(.saveFailed(error)))
            }
        }
        .eraseToAnyPublisher()
    }
}



