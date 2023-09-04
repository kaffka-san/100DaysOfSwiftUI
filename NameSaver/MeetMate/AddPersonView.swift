//
//   AddPersonView.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @State var photoPickerItem: PhotosPickerItem?
    @State var image = UIImage()
    @State private var name = ""
    @State private var company = ""

    @State var onSave: (Person) -> Void

    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Image(uiImage: image)
                    .resizable()
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .padding(.horizontal)

                TextField("Eneter name", text: $name)
                TextField("EnterCompany", text: $company)
            }
            .toolbar {
                Button("Save") {
                    onSave(Person(name: name, company: company, image: image))
                    dismiss()
                }
            }
            .onAppear{
                Task {
                    if let data = try? await photoPickerItem?.loadTransferable(type: Data.self) {

                        if let uiImage = UIImage(data: data) {
                           image = uiImage
                            return
                        }
                    }
                    print("Failed")
                }
            }
            .navigationTitle("Add a Person")
        }
    }
}

//struct AddPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPersonView(photoPickerItem: PhotosPicker(<#LocalizedStringKey#>, selection: <#Binding<PhotosPickerItem?>#>), onSave: {_ in })
//    }
//}
