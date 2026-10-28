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
    
    var imageFilename: String {
        "\(id.uuidString).jpg"
    }
    
    init(name: String, id: UUID = UUID()) {
        self.name = name
        self.id = id
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
    }
}

extension Person {
    static let preview = Person(name: "Example")
}
