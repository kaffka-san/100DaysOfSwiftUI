//
//  ContentView.swift
//  BookWorm
//
//  Created by Anastasia Lenina on 16.07.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment (\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    @State private var isShowingAddBook = false
        var body: some View {
            NavigationView {
                Form {
                    ForEach(books) { book in
                        NavigationLink {
                            DetailView(book: book)
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "no title")
                                        .font(.headline)
                                    Text(book.author ?? "no author")
                                        .font(.body)
                                }
                                .foregroundColor(book.rating < 2 ? .red : .black)
                                Spacer()
                                Text(book.date ?? Date.distantPast, style: .date)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.secondary)
                            }
                        }


                    }
                    .onDelete(perform: deleteBooks)
                }
                
                .navigationTitle("Book Worm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(){
                            isShowingAddBook.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add Book")
                            }

                        }
                    }
                    ToolbarItem (placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $isShowingAddBook) {
                    AddBook()
                }

            }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
       // try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
