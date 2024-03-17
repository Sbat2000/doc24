//
//  DoctorPreviewView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 14.03.2024.
//

import SwiftUI
import Combine

struct DoctorPreviewView: View {
    
    private var doctor: DoctorModel
    
    init(doctor: DoctorModel) {
        self.doctor = doctor
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(alignment: .top) {
                DoctorAvatarView(avatarUrl: doctor.avatar)
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 20)
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(doctor.lastName) \n\(doctor.firstName) \(doctor.patronymic)")
                        .font(.headline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    HStack {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .foregroundColor(index < doctor.rank ? Color.doct24Pink : Color.gray)
                                .font(.system(size: 12))
                        }
                        .font(.system(size: 12))
                        .padding(-2.2)
                    }
                    Text("\(doctor.position ?? "") • стаж \(doctor.experience)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(doctor.minPrice)
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                Spacer()
                Button(action: {
                    print("Like")
                }) {
                    Image(systemName: doctor.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(doctor.isFavorite ? .pink : .gray)
                }
                .font(.system(size: 24))
                .buttonStyle(PlainButtonStyle())
            }
            
            Button(action: {
                print("Записаться")
            }) {
                Text(doctor.nearestReceptionTime != nil ? "Записаться" : "Нет свободного расписания")
                    .font(.headline)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .buttonStyle(PlainButtonStyle())
            .disabled(doctor.nearestReceptionTime == nil)
            .background(doctor.nearestReceptionTime != nil ? Color.doct24Pink : Color.backgroundGray)
            .foregroundColor(doctor.nearestReceptionTime != nil ? .white : .blackText)
            .cornerRadius(10)
        }
        .background(Color.white)
    }
}

//struct DoctorView_Previews: PreviewProvider {
//    static var previews: some View {
//        DoctorPreviewView()
//    }
//}
