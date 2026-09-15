//
//  AddBookView.swift
//  Bookworm
//
//  Created by Yaroslav on 9/14/26.
//
import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var genre: Genre = .fantasy
    @State private var review = ""
    @State private var rating = 3


    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book name", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue)
                        }
                    }
                }
                Section("Write a short review") {



                    TextEditor(text: $review)
                        .onChange(of: review) {
                            if review.count > 500 {
                                review = String(review.prefix(500))
                            }
                        }
                    Text("\(review.count)/500")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
                
                Section("Rate book") {

                    RatingView(rating: $rating)
                }
                .buttonStyle(.plain)

                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
