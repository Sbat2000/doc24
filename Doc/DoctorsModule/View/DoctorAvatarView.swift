//
//  DoctorAvatarView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 16.03.2024.
//

import SwiftUI
import Kingfisher

struct DoctorAvatarView: View {
    var avatarUrl: String?
    
    var body: some View {
        Group {
            if let avatarUrl = avatarUrl, let url = URL(string: avatarUrl) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }
        }
    }
}
