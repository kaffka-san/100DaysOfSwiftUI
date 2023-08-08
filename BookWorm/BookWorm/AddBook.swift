//
//  AddBook.swift
//  BookWorm
//
//  Created by Anastasia Lenina on 16.07.2023.
//

import SwiftUI
import CoreData
struct AddBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var author = ""
    @State private var title = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var genre = "Fantasy"
    let genres = ["Fantasy", "Poetry", "Horror", "Kids", "Mystery",
                  "Romance", "Thriller"]
    @State private var isAlertShown = false
    @State private var titleAlert = ""
    @State private var alertMessage = ""
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Book name", text: $title)
                    TextField("Author", text: $author)
                    Picker("genre", selection: $genre) {
                        ForEach(genres, id: \.self) {genre in
                            Text(genre)
                        }
                    }

                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)

                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        if author.isEmpty || title.isEmpty || review.isEmpty {
                            titleAlert = "Error"
                            alertMessage = "Please fill out the form"
                            isAlertShown = true
                            return
                        }
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.author = author
                        newBook.title = title
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        newBook.date = Date.now
                        try? moc.save()
                        dismiss()
                    } .alert(titleAlert, isPresented: $isAlertShown) {

                        Button("OK") { }
                    }
                    message: {
                        Text(alertMessage)
                    }


                }
           

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            navigationTitle("Add Book")
        }
    }

}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
