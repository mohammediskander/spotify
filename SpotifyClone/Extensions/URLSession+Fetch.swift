//
//  Session+Fetch.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

extension URLSession {
    
    enum URLSessionFetchError: Error {
        case unexpectedError
        case decodingError
    }
    
    final func fetch<T: Codable>(with endpoint: Router, _ type: T.Type, completion: @escaping (Result<T, Swift.Error>) -> Void) throws {
        do {
            let urlRequest = try endpoint.asURLRequest()
            self.dataTask(with: urlRequest) {
                data, response, error in
                
                guard let data = data else {
                    guard let error = error else {
                        completion(.failure(URLSessionFetchError.unexpectedError))
                        return
                    }
                    completion(.failure(error))
                    return
                }
                
                do {
                    
                    guard let decoded = try JSON.decoder().decode(T?.self, from: data) else {
                        completion(.failure(URLSessionFetchError.decodingError))
                        return
                    }
                    
                    completion(.success(decoded))
                    
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            throw error
        }
    }
}
