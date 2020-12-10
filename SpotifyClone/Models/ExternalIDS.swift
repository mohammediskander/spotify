// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let externalIDS = try ExternalIDS(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.externalIDSTask(with: url) { externalIDS, response, error in
//     if let externalIDS = externalIDS {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    var upc: String
}

// MARK: ExternalIDS convenience initializers and mutators

extension ExternalIDS {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExternalIDS.self, from: data)
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
        upc: String? = nil
    ) -> ExternalIDS {
        return ExternalIDS(
            upc: upc ?? self.upc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
