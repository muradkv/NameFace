//
//  AddPersonView.swift
//  NameFace
//
//  Created by murad on 01.11.2026.
//

import SwiftUI

struct AddPersonView: View {
    @Bindable var viewModel: PeopleViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    photoPreview
                }
                
                Section("Details") {
                    TextField("Name", text: $viewModel.newPersonName)
                }
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.resetAddPersonState()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveNewPerson()
                    }
                    .disabled(viewModel.isSaveDisabled)
                }
            }
        }
        .onDisappear {
            viewModel.resetAddPersonState()
        }
    }
    
    @ViewBuilder
    private var photoPreview: some View {
        if let data = viewModel.pendingImageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 280)
                .clipShape(.rect(cornerRadius: 12))
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    let vm = PeopleViewModel()
    vm.pendingImageData = UIImage(systemName: "person.fill")?.pngData()
    return AddPersonView(viewModel: vm)
}
