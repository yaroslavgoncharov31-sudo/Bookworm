import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: Genre
    var review: String
    var rating: Int

    init(title: String, author: String, genre: Genre, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
