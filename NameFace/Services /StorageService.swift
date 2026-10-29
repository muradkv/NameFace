//
//  StorageService.swift
//  NameFace
//
//  Created by murad on 28.10.2026.
//

import Foundation

struct StorageService {
    private let savePath = URL.documentsDirectory.appending(path: "SavedPeople.json")
    
    func loadPeople() -> [Person] {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            return []
        }
    }
    
    func savePeople(_ people: [Person]) throws {
        let data = try JSONEncoder().encode(people)
        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
    }
    
    func loadImageData(filename: String) -> Data? {
        let url = URL.documentsDirectory.appending(path: filename)
        return try? Data(contentsOf: url)
    }
    
    func saveImage(_ data: Data, filename: String) throws {
        let url = URL.documentsDirectory.appending(path: filename)
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
}
