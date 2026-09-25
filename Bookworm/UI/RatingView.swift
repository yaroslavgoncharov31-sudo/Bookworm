import SwiftUI

struct RatingView: View {

    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    @State private var bounceCounter: [Int: Int] = [:]
    var body: some View {
        HStack {
        if !label.isEmpty {
            Text(label)
        }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                    bounceCounter[number, default: 0] += 1
                } label: {
                    (number > rating ? (offImage ?? onImage) : onImage)
                        .foregroundStyle(number > rating ? offColor : onColor)
                        .symbolEffect(.bounce, value: bounceCounter[number, default: 0])
                        .sensoryFeedback(.selection, trigger: bounceCounter)
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
