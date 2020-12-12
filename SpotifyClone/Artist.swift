// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artist = try Artist(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.artistTask(with: url) { artist, response, error in
//     if let artist = artist {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Artist
struct Artist: Codable {
    var externalUrls: ExternalUrls
    var followers: Followers
    var genres: [String]
    var href: String
    var id: String
    var images: [Image]
    var name: String
    var popularity: Int
    var type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: Artist convenience initializers and mutators

extension Artist {
    init(data: Data) throws {
        self = try JSON.decoder().decode(Artist.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
            externalUrls: ExternalUrls? = nil,
            followers: Followers? = nil,
            genres: [String]? = nil,
            href: String? = nil,
            id: String? = nil,
            images: [Image]? = nil,
            name: String? = nil,
            popularity: Int? = nil,
            type: String? = nil,
            uri: String? = nil
        ) -> Artist {
            return Artist(
                externalUrls: externalUrls ?? self.externalUrls,
                followers: followers ?? self.followers,
                genres: genres ?? self.genres,
                href: href ?? self.href,
                id: id ?? self.id,
                images: images ?? self.images,
                name: name ?? self.name,
                popularity: popularity ?? self.popularity,
                type: type ?? self.type,
                uri: uri ?? self.uri
            )
        }

    func jsonData() throws -> Data {
        return try JSON.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
