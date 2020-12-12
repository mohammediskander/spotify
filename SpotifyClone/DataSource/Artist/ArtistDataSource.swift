//
//  ArtistDataSource.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 11/12/2020.
//

import Foundation

protocol ArtistDataSourceDelegate: AnyObject {
    
}

class ArtistDataSource: NSObject {
    
    static var shared = ArtistDataSource()
    weak var delegate: ArtistDataSourceDelegate?
    private let artistsFetcher: Fetcher<Artist> = Fetcher()
    
    private var requests: [IndexPath: FetchingRequest<Artist>?] = [:]
    
    var data: [Artist] = []
    
    func fetchArtist(with ids: [String]) {
        try? URLSession.shared.fetch(with: ArtitsRouter.getSeveralArtits(ids: ids.joined(separator: ",")), [String: [Artist]].self) {
            result in
            
            switch result {
            case let .success(data):
                guard let artits = data["artists"] else { return }
                
                self.data.append(contentsOf: artits)
                
            case let .failure(error):
                print("ERR::\(error)")
            }
        }
    }
    
    func fetchAlbum(for artist: Artist) {
        let tempIndexPath = IndexPath(row: 0, section: 0)
        
        let request = artistsFetcher.fetch(with: ArtitsRouter.getAnArtist(id: artist.id), priority: .high) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                
                self.data.append(data)
                
                print("\(self.data.first!.name) has \(self.data.first!.followers.total) on Spotify.")
                
                self.requests[tempIndexPath] = nil
            case let .failure(error):
                print("\(#function) ERR::\(error)")
            }
        }
        
        self.requests[tempIndexPath] = request
    }
    
}

struct SpotifyArtitsResponse: Codable {
    var artists: [Artist]?
}
