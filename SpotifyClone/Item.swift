// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let item = try Item(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.itemTask(with: url) { item, response, error in
//     if let item = item {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Item
struct Item: Codable {
    var artists: [Artist]?
    var availableMarkets: [String]?
    var discNumber, durationMS: Int?
    var explicit: Bool?
    var externalUrls: ExternalUrls?
    var href: String?
    var id, name: String?
    var previewURL: String?
    var trackNumber: Int?
    var type, uri: String?

    enum CodingKeys: String, CodingKey {
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id, name
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: Item convenience initializers and mutators

extension Item {
    init(data: Data) throws {
        self = try JSON.decoder().decode(Item.self, from: data)
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
        artists: [Artist]?? = nil,
        availableMarkets: [String]?? = nil,
        discNumber: Int?? = nil,
        durationMS: Int?? = nil,
        explicit: Bool?? = nil,
        externalUrls: ExternalUrls?? = nil,
        href: String?? = nil,
        id: String?? = nil,
        name: String?? = nil,
        previewURL: String?? = nil,
        trackNumber: Int?? = nil,
        type: String?? = nil,
        uri: String?? = nil
    ) -> Item {
        return Item(
            artists: artists ?? self.artists,
            availableMarkets: availableMarkets ?? self.availableMarkets,
            discNumber: discNumber ?? self.discNumber,
            durationMS: durationMS ?? self.durationMS,
            explicit: explicit ?? self.explicit,
            externalUrls: externalUrls ?? self.externalUrls,
            href: href ?? self.href,
            id: id ?? self.id,
            name: name ?? self.name,
            previewURL: previewURL ?? self.previewURL,
            trackNumber: trackNumber ?? self.trackNumber,
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
