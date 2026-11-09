//
//  PeopleListView.swift
//  NameFace
//
//  Created by murad on 23.10.2026.
//

import SwiftUI
import PhotosUI

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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(
                        selection: $viewModel.selectedItem,
                        matching: .images
                    ) {
                        Image(systemName: "plus")
                    }
                }
                
            }
            .onChange(of: viewModel.selectedItem) {
                Task {
                    await viewModel.loadSelectedImage()
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddSheet) {
                AddPersonView(viewModel: viewModel)
            }
            .alert("Error", isPresented: $viewModel.isShowingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    PeopleListView()
}
