//
//  PersonRowView.swift
//  NameFace
//
//  Created by murad on 31.10.2026.
//

import SwiftUI

struct PersonRowView: View {
    let person: Person
    let imageData: Data?
    
    var body: some View {
        HStack(spacing: 16) {
            avatarView
                .frame(width: 48, height: 48)
                .clipShape(.circle)
            
            Text(person.name)
                .font(.headline)
        }
    }
    
    @ViewBuilder
    private var avatarView: some View {
        if let imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    let sampleImageData = UIImage(systemName: "photo.artframe")?.pngData()
    
    PersonRowView(person: Person.preview, imageData: nil)
    PersonRowView(person: Person.preview, imageData: sampleImageData)
}
