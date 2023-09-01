//
//  EditView.swift
//  BucketList
//
//  Created by Anastasia Lenina on 31.08.2023.
//

import SwiftUI

struct EditView: View {
    @Environment (\.dismiss) var dismiss
    var onSave: (Location) -> Void

    @StateObject var editViewViewModel: EditViewViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Edit title", text: $editViewViewModel.name)
                    TextField("Edit description", text: $editViewViewModel.description)
                }
                Section {
                    if editViewViewModel.state == LoadingState.loading {
                        ProgressView()
                    } else if editViewViewModel.state == LoadingState.failed {
                        Text("There was an error. Try again later")
                    } else {
                        ForEach(editViewViewModel.pages, id: \.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    }
                } header: {
                    Text("Places nearby")
                }
            }
            .navigationTitle("Edit mode")
            .toolbar {
                Button("Save") {
                    onSave(editViewViewModel.save())
                    dismiss()
                }
            }
        }
        .onAppear {
            Task {
                await editViewViewModel.fetchData(
                    latitude: editViewViewModel.location.latitude,
                    longitude: editViewViewModel.location.longitude
                )
            }
        }
    }

    init(_ editViewViewModel: EditViewViewModel, onSave: @escaping (Location)->Void) {
        self.onSave = onSave
      _editViewViewModel = StateObject(wrappedValue: editViewViewModel)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(EditViewViewModel(location: Location.example), onSave: { _ in })
    }
}

