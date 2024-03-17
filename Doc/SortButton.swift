//
//  SortButton.swift
//  Doc
//
//  Created by Aleksandr Garipov on 17.03.2024.
//

import SwiftUI

enum SortCriterion {
    case price
    case age
    case rating
}

enum SortDirection {
    case ascending
    case descending
}

struct SortButton: View {
    let title: String
    let criterion: SortCriterion
    @Binding var selectedCriterion: SortCriterion
    @Binding var sortDirection: SortDirection 

    var body: some View {
        Button(action: {
            selectedCriterion = criterion
            sortDirection = (sortDirection == .ascending) ? .descending : .ascending
        }) {
            HStack {
                Text(title)
                    .foregroundColor(selectedCriterion == criterion ? Color.white : Color.gray)
                if selectedCriterion == criterion {
                    Image(systemName: sortDirection == .ascending ? "arrow.up" : "arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 12)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(selectedCriterion == criterion ? Color.pink : Color.white)
            .foregroundColor(Color.white)
        }
    }
}


struct SortButton_Previews: PreviewProvider {
    @State static var selectedCriterion: SortCriterion = .price
    @State static var sortDirection: SortDirection = .descending
        
        static var previews: some View {
            VStack {
                SortButton(title: "По цене", criterion: .price, selectedCriterion: $selectedCriterion, sortDirection: $sortDirection)
                SortButton(title: "По стажу", criterion: .age, selectedCriterion: $selectedCriterion, sortDirection: .constant(.descending))
            }
            .padding()
        }
}
