//
//  PersonDetailView.swift
//  NameFace
//
//  Created by murad on 02.11.2026.
//

import SwiftUI
import MapKit

enum DisplayMode {
    case photo
    case map
}

struct PersonDetailView: View {
    @State private var displayMode: DisplayMode = .photo
    
    let person: Person
    let imageData: Data?
    
    private var coordinate: CLLocationCoordinate2D? {
        guard let latitude = person.latitude, let longitude = person.longitude else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var body: some View {
        ZStack {
            if displayMode == .photo {
                photoContent
            } else {
                mapContent
            }
        }
        .safeAreaInset(edge: .bottom) {
            Picker("Display", selection: $displayMode) {
                Text("Photo").tag(DisplayMode.photo)
                Text("Map").tag(DisplayMode.map)
            }
            .pickerStyle(.segmented)
            .padding()
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ContentUnavailableView(
                "Photo not found",
                systemImage: "photo.badge.exclamationmark"
            )
        }
    }
    
    @ViewBuilder
    private var mapContent: some View {
        if let coordinate {
            let region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            Map(initialPosition: .region(region), interactionModes: .all) {
                Marker(person.name, coordinate: coordinate)
            }
        } else {
            ContentUnavailableView(
                "Location not recorded",
                systemImage: "location.slash",
                description: Text("This contact was added without location data.")
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

#Preview("With Photo and Location") {
    NavigationStack {
        PersonDetailView(
            person: Person.previewWithLocation,
            imageData: UIImage(systemName: "photo.artframe")?.pngData()
        )
    }
}

#Preview("Missing Photo") {
    NavigationStack {
        PersonDetailView(person: Person.preview, imageData: nil)
    }
}
