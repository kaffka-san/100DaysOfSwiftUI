//
//  DetailView.swift
//  BookWorm
//
//  Created by Anastasia Lenina on 21.07.2023.
//

import SwiftUI
import CoreData
struct DetailView: View {
    let book: Book
    @Environment (\.managedObjectContext) var moc
    @Environment (\.dismiss) var dismiss
    @State private var isAlertShown = false
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(book.title ?? "Unknown Book")
                .font(.largeTitle)
                .foregroundColor(.secondary)
                .padding()
            Text(book.review ?? "No review")
                .font(.body)
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            Text(book.date ?? Date.distantPast, style: .date)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.secondary)
                .padding()

        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Item", isPresented: $isAlertShown, actions: {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                deleteBook()
                dismiss()
            }
        }, message: {
            Text("Are you sure?")
        })
        .toolbar {
            ToolbarItem {
                Button{
                    isAlertShown = true
                } label: {
                    HStack {
                        Label("Delete this book", systemImage: "trash")
                    }
                }
            }
        }
    }
    func deleteBook() {
        try? moc.delete(book)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}
