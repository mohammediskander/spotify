//
//  AlbumDataSource.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

protocol AlbumDataSourceDelegate: AnyObject {
    func dataLoaded()
}

class AlbumDataSource: NSObject {
    
    static var shared = AlbumDataSource()
    weak var delegate: AlbumDataSourceDelegate?
    private let albumFetcher: Fetcher<[String: [Album]]> = Fetcher()
    private var fetchRequest: FetchingRequest<[String: [Album]]>?
    
    var albums: [Album] = []
    
    func fetchAlbum(with ids: [String]) {
        fetchRequest = self.albumFetcher.fetch(with: AlbumRouter.getSeveralAlbums(ids: ids.joined(separator: ","), market: nil), priority: .high) {
            [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case let .success(spotifyResponse):

                guard let albums = spotifyResponse["albums"] else { return }
                
                self.albums.append(contentsOf: albums)
                self.fetchRequest = nil
                
                ArtistDataSource.shared.fetchAlbum(for: self.albums.last!.artists.first!)
            case let .failure(error):
                print("\(#function) ERR::\(error)")
            }
        }
    }
}
