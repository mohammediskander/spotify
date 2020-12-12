//
//  AlbumFetcher.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

/// Fetcher is the class to fetch data from external api using `OperationQueue`
class Fetcher<T: Codable> {
    
    enum Error: Swift.Error {
        case canceled
    }
    
    enum Priority {
        case high
        case low
    }
    
    typealias FetcherResult = Result<T, Swift.Error>
    typealias ResultHandler = (FetcherResult) -> Void
    
    private var maxFetchers: Int!
    init(maxFetchers maxConcurrentOperationCount: Int = 3) {
        self.maxFetchers = maxConcurrentOperationCount
    }
    
    private lazy var fetcingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = self.maxFetchers
        
        return queue
    }()
    
    /// Add Fetching process to the queue
    /// - Parameters:
    ///   - endpoint: The endpoint to fetch
    ///   - priority: The priority of the fetch operation
    ///   - completion: The completion callback; this will execute after the operation finish
    /// - Returns: The fetch request
    @discardableResult
    func fetch(
        with endpoint: Router,
        priority: Fetcher<T>.Priority,
        completion: @escaping ResultHandler
    ) -> FetchingRequest<T> {
        let operation = FetchingOperation<T>(endpoint: endpoint, priority: priority, completion: completion)
        let request = FetchingRequest<T>(operation: operation, queue: self.fetcingQueue)
        
        return request
    }
}
