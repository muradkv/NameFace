//
//  Person.swift
//  NameFace
//
//  Created by murad on 23.10.2026.
//

import Foundation

struct Person: Comparable, Identifiable, Hashable, Codable {
    let name: String
    let id: UUID
    let latitude: Double?
    let longitude: Double?
    
    var imageFilename: String {
        "\(id.uuidString).jpg"
    }
    
    init(name: String, id: UUID = UUID(), latitude: Double? = nil, longitude: Double? = nil) {
        self.name = name
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(UUID.self, forKey: .id)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
    }
}

extension Person {
    static let preview = Person(name: "Example")
    
    static let previewWithLocation = Person(
        name: "Example",
        latitude: 37.3349,
        longitude: -122.0090   
    )
}
