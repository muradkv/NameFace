//
//  PersonDetailView.swift
//  NameFace
//
//  Created by murad on 02.11.2026.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person
    let imageData: Data?
    
    var body: some View {
        VStack {
            photoContent
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var photoContent: some View {
        if let imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 16))
                .padding()
        } else {
            ContentUnavailableView(
                "Photo not found",
                systemImage: "photo.badge.exclamationmark"
            )
        }
    }
}

#Preview("With Photo") {
    NavigationStack {
        PersonDetailView(
            person: Person.preview,
            imageData: UIImage(systemName: "photo.artframe")?.pngData()
        )
    }
}

#Preview("Missing Photo") {
    NavigationStack {
        PersonDetailView(person: Person.preview, imageData: nil)
    }
}
