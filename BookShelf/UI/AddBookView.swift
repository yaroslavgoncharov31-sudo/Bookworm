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
    @State private var isShowingAlert = false
    
    @FocusState private var focusedField: Field?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book name", text: $title)
                        .focused($focusedField, equals: .title)
                    TextField("Author's name", text: $author)
                        .focused($focusedField, equals: .author)


                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue)
                        }
                    }
                }
                Section("Write a short review") {
                    TextEditor(text: $review)
                        .focused($focusedField, equals: .review)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                if focusedField == .review {
                                    Spacer()

                                    Button("Done") {
                                        focusedField = nil
                                    }
                                    .padding(.bottom, 5)
                                }
                            }
                        }
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
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
                        if newBook.isBookValid {
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            isShowingAlert = true
                        }
                    }
                    .alert("Invalid input", isPresented: $isShowingAlert) {
                    } message: {
                        Text("Invalid title or author")
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
