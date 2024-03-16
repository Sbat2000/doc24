//
//  DataConverter.swift
//  Doc
//
//  Created by Aleksandr Garipov on 16.03.2024.
//

import Foundation

struct DataConverter {
    static func convertUsersToDoctors(users: [User]) -> [DoctorModel] {
        return users.map { user -> DoctorModel in
            var prices = [String: Int]()
            if user.textChatPrice > 0 {
                prices["textChat"] = user.textChatPrice
            }
            if user.videoChatPrice > 0 {
                prices["videoChat"] = user.videoChatPrice
            }
            if user.homePrice > 0 {
                prices["home"] = user.homePrice
            }
            if user.hospitalPrice > 0 {
                prices["hospital"] = user.hospitalPrice
            }
            
            let minPrice = prices.values.compactMap { $0 }.min()
            let minPriceString = minPrice != nil ? "от \(minPrice!) ₽" : "нет данных о ценах"
            
            let totalExperience = user.workExperience.reduce(0) { total, experience in
                let startDate = experience.startDate ?? 0
                let endDate = experience.endDate ?? Date().timeIntervalSince1970
                return total + max(endDate - startDate, 0)
            }
            let totalExperienceYears = Int(round(totalExperience / (3600 * 24 * 365)))
            
            return DoctorModel(
                id: user.id,
                firstName: user.firstName,
                patronymic: user.patronymic,
                lastName: user.lastName,
                gender: user.genderLabel,
                rank: user.rank,
                avatar: user.avatar,
                prices: prices,
                position: user.specialization.first?.name ?? "Не указано",
                experience: formatYears(totalExperienceYears),
                minPrice: minPriceString,
                isFavorite: user.isFavorite,
                nearestReceptionTime: user.nearestReceptionTime
            )
            
            func formatYears(_ years: Int) -> String {
                if years == 0 {
                    return ""
                }
                
                let lastDigit = years % 10
                let lastTwoDigits = years % 100
                
                if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
                    return "• стаж \(years) лет"
                } else if lastDigit == 1 {
                    return "• стаж \(years) год"
                } else if lastDigit >= 2 && lastDigit <= 4 {
                    return "• стаж \(years) года"
                } else {
                    return "• стаж \(years) лет"
                }
            }
            
            
        }
    }
}
