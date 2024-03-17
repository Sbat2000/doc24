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
            let minPriceString = minPrice != nil ? "от \(minPrice!) ₽" : "нет данных"
            
            let totalExperience = user.workExperience.reduce(0) { total, experience in
                let startDate = experience.startDate ?? 0
                let endDate = experience.endDate ?? Date().timeIntervalSince1970
                if startDate > 0 && endDate > 0 {
                    return total + max(endDate - startDate, 0)
                } else {
                    return total
                }
                
            }
            let totalExperienceYears = Int(round(totalExperience / (3600 * 24 * 365)))
            
            return DoctorModel(
                id: user.id,
                firstName: user.firstName,
                patronymic: user.patronymic,
                lastName: user.lastName,
                gender: user.genderLabel,
                rank: max(5, Int(round(user.ratingsRating))),
                avatar: user.avatar,
                prices: prices,
                position: user.specialization.first?.name ?? "Не указано",
                experience: formatYears(totalExperienceYears),
                minPrice: minPriceString,
                isFavorite: user.isFavorite,
                nearestReceptionTime: user.nearestReceptionTime,
                educationTypeLabel: user.educationTypeLabel?.name ?? "нет данных",
                category: convertCategory(user.category),
                specialization: firstSpecializationName(from: user.specialization),
                currentPosition: currentPosition(from: user.workExperience),
                descriptions: doctorsDescriptions.randomElement() ?? "нет описания"
            )
        }
        
        
        func formatYears(_ years: Int) -> String {
            if years == 0 {
                return "не указан"
            }
            
            let lastDigit = years % 10
            let lastTwoDigits = years % 100
            
            if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
                return "\(years) лет"
            } else if lastDigit == 1 {
                return "\(years) год"
            } else if lastDigit >= 2 && lastDigit <= 4 {
                return "\(years) года"
            } else {
                return "\(years) лет"
            }
        }
        
        //MARK: - категория врача
        
        func convertCategory(_ category: Int) -> String {
            switch category {
            case 0:
                return "Врач"
            case 1:
                return "Врач первой категории"
            case 2:
                return "Врач второй категории"
            case 3:
                return "Врач высшей категории"
            default:
                return "Категория не определена"
            }
        }
        
        //MARK: - Достаем первую специализацию из массива
        
        func firstSpecializationName(from specializations: [Specialization]) -> String {
            if let firstSpecialization = specializations.first {
                return firstSpecialization.name
            } else {
                return "Нет данных"
            }
        }
        
        //MARK: - Достаем первое место работы, где работает до сих пор
        
        func currentPosition(from workExperiences: [WorkExperience]) -> String {
            if let currentExperience = workExperiences.first(where: { $0.untilNow ?? false }) {
                return currentExperience.position
            } else {
                return "Нет данных"
            }
        }
    }
}

//MARK: - Мок описания

fileprivate let doctorsDescriptions = [
    "Специализируется на нейрохирургии. Опыт ведения сложных операций на мозге и позвоночнике. Имеет международное признание в области нейрохирургии. Говорит на трех языках: английском, французском и испанском.",
    "Врач-кардиолог с опытом работы в крупных кардиологических центрах. Специализируется на лечении сердечных заболеваний и проведении катетерных процедур. Автор научных статей по кардиологии.",
    "Ортопед-травматолог с опытом восстановления после тяжелых травм и операций на опорно-двигательном аппарате. Осуществляет реабилитацию и реконструкцию суставов. Работал в лучших клиниках США и Европы.",
    "Педиатр с фокусом на аллергологии и иммунологии у детей. Опыт диагностики и лечения аллергических заболеваний. Разработал индивидуальные программы лечения для детей с аллергическими реакциями.",
    "Гинеколог с опытом работы в акушерских отделениях. Специализируется на лечении женских заболеваний и проведении родовспоможения. Осуществляет консультации по планированию беременности.",
    "Офтальмолог с опытом в лечении глазных заболеваний. Выполняет операции на глазах и консервативное лечение. Имеет сертификаты от международных офтальмологических ассоциаций.",
    "Эндокринолог с узкой специализацией на диабете и нарушениях обмена веществ. Проводит комплексное лечение эндокринных заболеваний. Автор множества научных статей по эндокринологии.",
    "Психиатр с опытом работы в клиниках для психических расстройств. Специализируется на депрессии, тревожных расстройствах и психозах. Проводит терапевтические сеансы и назначает медикаментозное лечение.",
    "Иммунолог с фокусом на исследованиях иммунной системы. Опыт работы с иммунодефицитными состояниями и аутоиммунными заболеваниями. Проводит вакцинацию и прививочные кампании.",
    "Хирург-онколог с опытом в удалении опухолей различной локализации. Ведет химиотерапевтическое и радиологическое лечение рака. Участвует в клинических исследованиях новых методов лечения онкологических заболеваний."
]
