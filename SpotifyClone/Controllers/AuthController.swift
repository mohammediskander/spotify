
//
//  LoginController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit
import OAuthSwift

enum SpotifyOAuth: String {
    case clientSecret = "3647b822d8f44142a719821fe6552897"
    case clientId = "5a7992d6a04e460787715d93883aa8cd"
    case scope = "user-read-private%20user-read-email"
    case redirectURI = "spotifyclone://spotify-login-callback"
}

class AuthController: UIViewController {
    
    var oauthswift: OAuth2Swift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oauthswift = OAuth2Swift(
            consumerKey: SpotifyOAuth.clientId.rawValue,
            consumerSecret: SpotifyOAuth.clientSecret.rawValue,
            authorizeUrl: "https://accounts.spotify.com/authorize",
            accessTokenUrl: "https://accounts.spotify.com/api/token",
            responseType: "code"
        )
        
        self.oauthswift = oauthswift
        handleAuth2()
    }
    
    func handleAuth2() {
        oauthswift?.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift!)
        let _ = oauthswift?.authorize(
            withCallbackURL: SpotifyOAuth.redirectURI.rawValue,
            scope: SpotifyOAuth.scope.rawValue,
            state: "SPOTIFY"
        ) {
            result in
            
            switch result {
            case .success(let (credential, _, _)):
                KeyChain.save(key: "spotify.user.oauthToken", data: Data(from: credential.oauthToken))
                AlbumDataSource.shared.fetchAlbum(with: [
                    "41MnTivkwTO3UUJ8DrqEJJ",
                    "6JWc4iAiJ9FjyK0B59ABb4",
                    "6UXCm6bOO4gFlDQZV5yL37"
                ])
            case .failure(let error):
                print("ERR::\(error)")
            }
        }
    }
    
}
