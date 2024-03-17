//
//  DoctorDetailView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 16.03.2024.
//

import SwiftUI

struct DoctorDetailView: View {
    
    private var doctor: DoctorModel
    @Environment(\.presentationMode) var presentationMode
    
    init(doctor: DoctorModel) {
        self.doctor = doctor
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                DoctorAvatarView(avatarUrl: doctor.avatar)
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 20)
                Text("\(doctor.lastName) \n\(doctor.firstName) \(doctor.patronymic)")
                    .font(.title2)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
            .padding()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(.clock)
                    Text("Опыт работы: \(doctor.experience)")
                }
                HStack {
                    Image(.pharmacy)
                    Text(doctor.category)
                }
                HStack {
                    Image(systemName: "graduationcap")
                    Text(doctor.educationTypeLabel)
                }
                HStack {
                    Image(.position)
                    
                    Text(doctor.currentPosition)
                }
            }
            .padding(.horizontal)
            .foregroundColor(.gray)
            Button(action: {
            }) {
                HStack {
                    Text("Стоимость услуг")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(doctor.minPrice)")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            ScrollView {
                Text(doctor.descriptions)
            }
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, 24)
            Spacer()
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
        .background(Color.background)
        .navigationTitle("Доктор")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.gray)
        })
        
        
    }
}

#Preview {
    DoctorDetailView(doctor: mockDoctor)
}

//MARK: - mock

fileprivate let mockDoctor = DoctorModel(
    id: "1",
    firstName: "Дарья",
    patronymic: "Сергеевна",
    lastName: "Семенова",
    gender: "Женский",
    rank: 1,
    avatar: nil,
    prices: ["Консультация": 600, "Общий анализ крови": 1200],
    position: "Педиатр",
    experience: "27 лет",
    minPrice: "от 600 ₽",
    isFavorite: true,
    nearestReceptionTime: 1_624_000_000, 
    educationTypeLabel: "1-й ММИ им. И.М.Сеченова",
    category: "Врач высшей категории",
    specialization: "Акушерство",
    currentPosition: "Поликлиника №1",
    descriptions: "Проводит диагностику и лечение терапевтических болезней. Осуществляет расшифровку и снятие ЭКГ. Дает рекомендации по диетологии. Доктор имеет опыт работы в России и за рубежом. Проводит консультации пациентов на английском языке."
)
