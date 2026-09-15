import SwiftUI

struct RatingView: View {

    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
        if label.isEmpty == false {
            Text(label)
        }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    (number > rating ? (offImage ?? onImage) : onImage)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
