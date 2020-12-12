//
//  ArtitsRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 11/12/2020.
//

import Foundation

enum ArtitsRouter: Router {
    
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/artists")
    
    case getAnArtist(id: String)
    case getAnArtitAlbums(id: String, includeGroups: String?, country: String?, limit: Int?, offset: Int?)
    case getAnArtitTopTracks(id: String, market: String)
    case getAnArtitRelateArtits(id: String)
    case getSeveralArtits(ids: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case let .getAnArtist(id):
            return String(format: "/%@", id)
        case let .getAnArtitAlbums(id, _, _, _, _):
            return String(format: "/%@/albums", id)
        case let .getAnArtitTopTracks(id, _):
            return String(format: "/%@/top-tracks", id)
        case let .getAnArtitRelateArtits(id):
            return String(format: "/%@/related-artists", id)
        case .getSeveralArtits:
            return "/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAnArtist:
            return [:]
        case .getAnArtitAlbums(_, includeGroups: let includeGroups, country: let country, limit: let limit, offset: let offset):
            var parameters: Parameters = [:]
            
            if let includeGroups = includeGroups {
                parameters["include_groups"] = includeGroups
            }
            
            if let country = country {
                parameters["country"] = country
            }
            
            if let limit = limit {
                parameters["limit"] = limit
            }
            
            if let offset = offset {
                parameters["offset"] = offset
            }
            
            return parameters
        case .getAnArtitTopTracks(_, market: let market):
            var parameters: Parameters = [:]
            
            parameters["market"] = market
            
            return parameters
        case .getAnArtitRelateArtits(_):
            return nil
        case let .getSeveralArtits(ids):
            let parameters: Parameters = ["ids": ids]
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: "\(ArtitsRouter.baseURL!)\(path)")!)
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if accessType == .some(.privateRoute) {
            
            let token = "Bearer \(KeyChain.load(key: "spotify.user.oauthToken")!.to(type: String.self))"
            
            urlRequest.addValue(token, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        if let parameters = parameters {
            do {
                if method == .get {
                    urlRequest.queryItems = parameters.toURLQueryItems()
                } else {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            }
        }
        
        return urlRequest
    }
    
    
}
