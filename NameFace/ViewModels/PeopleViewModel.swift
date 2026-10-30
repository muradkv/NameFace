//
//  PeopleViewModel.swift
//  NameFace
//
//  Created by murad on 30.10.2026.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable
@MainActor
final class PeopleViewModel {
    private(set) var people: [Person] = []
    
    var selectedItem: PhotosPickerItem?
    var pendingImageData: Data?
    var isShowingAddSheet = false
    var newPersonName = ""
    
    var isShowingError = false
    private(set) var errorMessage = ""
    
    private let storageService: StorageService
    
    var isSaveDisabled: Bool {
        newPersonName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || pendingImageData == nil
    }
    
    init(storageService: StorageService = StorageService()) {
        self.storageService = storageService
        people = storageService.loadPeople().sorted()
    }
    
    func loadSelectedImage() async {
        guard let selectedItem else { return }
        defer { self.selectedItem = nil }
        
        do {
            if let data = try await selectedItem.loadTransferable(type: Data.self) {
                pendingImageData = data
                newPersonName = ""
                isShowingAddSheet = true
            }
        } catch {
            errorMessage = "Failed to import photo: \(error.localizedDescription)"
            isShowingError = true
        }
    }
    
    func saveNewPerson() {
        let trimmedName = newPersonName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard
            !trimmedName.isEmpty,
            let imageData = pendingImageData
        else { return }
        
        let newPerson = Person(name: trimmedName)
        do {
            try storageService.saveImage(imageData, filename: newPerson.imageFilename)
            people.append(newPerson)
            people.sort()
            try storageService.savePeople(people)
            resetAddPersonState()
        } catch {
            errorMessage = "Failed to save person: \(error.localizedDescription)"
            isShowingError = true
        }
    }
    
    func imageData(for person: Person) -> Data? {
        storageService.loadImageData(filename: person.imageFilename)
    }
    
    func resetAddPersonState() {
        pendingImageData = nil
        newPersonName = ""
        isShowingAddSheet = false
    }
}
