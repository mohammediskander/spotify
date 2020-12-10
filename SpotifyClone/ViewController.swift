//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit
import OAuthSwift
import WebKit

enum SpotifyOAuth: String {
    case clientSecret = "3647b822d8f44142a719821fe6552897"
    case clientId = "5a7992d6a04e460787715d93883aa8cd"
    case scope = "user-read-private%20user-read-email"
    case redirectURI = "spotifyclone://spotify-login-callback"
}

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
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
    }
    
    @IBAction func handleAuth2() {
        oauthswift?.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift!)
        let _ = oauthswift?.authorize(
            withCallbackURL: SpotifyOAuth.redirectURI.rawValue,
            scope: SpotifyOAuth.scope.rawValue,
            state: "SPOTIFY"
        ) {
            [weak self] result in
            
            switch result {
            case .success(let (credential, response, parameters)):
                
                
                var urlRequest = URLRequest(url: URL(string: "https://api.spotify.com/v1/albums/?ids=41MnTivkwTO3UUJ8DrqEJJ,6JWc4iAiJ9FjyK0B59ABb4,6UXCm6bOO4gFlDQZV5yL37")!)
                
                urlRequest.allHTTPHeaderFields = [
                    "Authorization": "Bearer \(credential.oauthToken)"
                ]
                
                URLSession.shared.dataTask(with: urlRequest) {
                    data, response, error in
                    
                    guard let data = data else {
                        if let error = error {
                            print("ERR::\(error)")
                        } else {
                            print("ERR::Unexpected error occure.")
                        }
                        
                        return
                    }
                
                        do {
                            let decoder = JSONDecoder()
                            let decoded = try decoder.decode(SpotifyResponse.self, from: data)
                            
                            print(decoded.albums?.first?.tracks?.items?.count, decoded.albums?.first?.tracks?.items?.first?.name)
                        } catch {
                            print("ERR::\(error)")
                        }
                        
                }.resume()
                
            case .failure(let error):
                print("ERR::\(error)")
            }
        }
    }
    
}

