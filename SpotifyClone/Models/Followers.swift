// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let followers = try Followers(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.followersTask(with: url) { followers, response, error in
//     if let followers = followers {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Followers
struct Followers: Codable {
    var href: JSONNull
    var total: Int
}

// MARK: Followers convenience initializers and mutators

extension Followers {
    init(data: Data) throws {
        self = try JSON.decoder().decode(Followers.self, from: data)
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
        href: JSONNull? = nil,
        total: Int? = nil
    ) -> Followers {
        return Followers(
            href: href ?? self.href,
            total: total ?? self.total
        )
    }

    func jsonData() throws -> Data {
        return try JSON.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
