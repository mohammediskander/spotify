// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let externalUrls = try ExternalUrls(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.externalUrlsTask(with: url) { externalUrls, response, error in
//     if let externalUrls = externalUrls {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    var spotify: String
}

// MARK: ExternalUrls convenience initializers and mutators

extension ExternalUrls {
    init(data: Data) throws {
        self = try JSON.decoder().decode(ExternalUrls.self, from: data)
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
        spotify: String? = nil
    ) -> ExternalUrls {
        return ExternalUrls(
            spotify: spotify ?? self.spotify
        )
    }

    func jsonData() throws -> Data {
        return try JSON.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
