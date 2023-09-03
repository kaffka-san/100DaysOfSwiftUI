//
//  RatingView.swift
//  BookWorm
//
//  Created by Anastasia Lenina on 17.07.2023.
//

import SwiftUI

struct RatingView: View {
    var labelText = ""
    @Binding var rating: Int
    var maxValue = 5
    var onImage = Image(systemName: "star.fill")
    var offImage: Image?

    var body: some View {
        VStack {
            if !labelText.isEmpty {
                Text(labelText)
            }
            HStack {
                ForEach(1..<maxValue+1, id: \.self) { index in
                    getImageForNumber(num: index)
                        .foregroundColor(index <= rating ? .yellow : .gray)
                        .onTapGesture {
                            rating = index
                        }
                }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue(rating == 1 ? "\(rating) star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maxValue { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:  break
            }
        }
    }
    func getImageForNumber(num: Int) -> Image {
        if num <= rating {
            return onImage
        } else {
            return offImage ?? onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(5))
    }
}
