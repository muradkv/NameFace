//
//  PeopleListView.swift
//  NameFace
//
//  Created by murad on 23.10.2026.
//

import SwiftUI

struct PeopleListView: View {
    @State private var viewModel = PeopleViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.people.isEmpty {
                    ContentUnavailableView(
                        "No Contacts Yet",
                        systemImage: "person.crop.circle.badge.plus",
                        description: Text("Tap the plus button to import a photo and add a name.")
                    )
                } else {
                    List(viewModel.people) { person in
                        NavigationLink {
                            PersonDetailView(
                                person: person,
                                imageData: viewModel.imageData(for: person)
                            )
                        } label: {
                            PersonRowView(
                                person: person,
                                imageData: viewModel.imageData(for: person)
                            )
                        }
                    }
                }
            }
            .navigationTitle("People")
        }
    }
}

#Preview {
    PeopleListView()
}
