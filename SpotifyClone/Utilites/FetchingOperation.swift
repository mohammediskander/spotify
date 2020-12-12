//
//  AlbumFetchingOperation.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

class FetchingOperation<T: Codable>: Operation {
    var endpoint: Router?
    let completion: Fetcher<T>.ResultHandler
    
    enum Error: Swift.Error {
        case parsingError
    }
    
    init(endpoint: Router, priority: Fetcher<T>.Priority = .low, completion: @escaping Fetcher<T>.ResultHandler) {
        self.endpoint = endpoint
        self.completion = completion
        
        super.init()
        
        switch priority {
        case .high:
            self.qualityOfService = .userInitiated
            self.queuePriority = .high
        case .low:
            self.qualityOfService = .utility
            self.queuePriority = .low
        }
    }
    
    convenience init(operation: FetchingOperation<T>, priority: Fetcher<T>.Priority = .low) {
        guard let endpoint = operation.endpoint else {
            preconditionFailure("FETAL_ERR::Attempt to clone an operation with nil endpoint.")
        }
        
        self.init(endpoint: endpoint, priority: priority, completion: operation.completion)
    }
    
    override func cancel() {
        super.cancel()
        self.endpoint = nil
    }
    
    override func main() {
        guard let endpoint = self.endpoint else {
            self.completion(.failure(Fetcher<T>.Error.canceled))
            return
        }
        
        do {
            let session: URLSession = {
                let config = URLSessionConfiguration.default
                return URLSession(configuration: config)
            }()
            
            try session.fetch(with: endpoint, T.self) {
                [weak self] result in
                guard let self = self else { return }
                
                if case let .success(data) = result {
                    self.completion(.success(data))
                } else if case let .failure(error) = result {
                    self.completion(.failure(error))
                }
            }
        } catch {
            self.completion(.failure(error))
        }
    }
}
