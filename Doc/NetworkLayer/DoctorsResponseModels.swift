//
//  DoctorsModel.swift
//  Doc
//
//  Created by Aleksandr Garipov on 15.03.2024.
//

import Foundation

// Основная структура, соответствующая верхнему уровню JSON
struct Doctors: Decodable {
    let record: Record
    let metadata: Metadata // Исправлено для соответствия ключу JSON
}

// Метаданные, связанные с ответом API
struct Metadata: Decodable {
    let id: String
    let isPrivate: Bool
    let createdAt, name: String

    enum CodingKeys: String, CodingKey {
        case id
        case isPrivate = "private"
        case createdAt, name
    }
}

// Запись, содержащая основные данные и информацию о пользователях
struct Record: Decodable {
    let count: Int
    let previous: Int?
    let message: String
    let errors: String?
    let data: UserWrapper
}

// Оболочка для списка пользователей
struct UserWrapper: Decodable {
    let users: [User]
}

// Описание пользователя
struct User: Decodable {
    let id, slug, firstName, patronymic, lastName, gender: String
    let genderLabel: String
    let specialization: [Specialization]
    let ratings: [Rating]
    let ratingsRating: Double
    let seniority, textChatPrice, videoChatPrice, homePrice, hospitalPrice: Int
    let avatar: String?
    let nearestReceptionTime: Double?
    let freeReceptionTime: [FreeReceptionTime]
    let educationTypeLabel: EducationTypeLabel?
    let higherEducation: [HigherEducation]
    let workExperience: [WorkExperience]
    let advancedTraining: [AdvancedTraining]
    let rank: Int
    let rankLabel: String
    let scientificDegree: Int
    let scientificDegreeLabel: String
    let category: Int
    let categoryLabel: String
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id, slug, firstName, patronymic, lastName, gender, genderLabel, specialization, ratings, ratingsRating, seniority, textChatPrice, videoChatPrice, homePrice, hospitalPrice, avatar, nearestReceptionTime, freeReceptionTime, educationTypeLabel, higherEducation, workExperience = "workExpirience", advancedTraining, rank, rankLabel, scientificDegree, scientificDegreeLabel, category, categoryLabel, isFavorite
    }
}

// Структуры, описывающие детализированные атрибуты пользователя
struct AdvancedTraining: Decodable {
    let id: Int
    let organization, position: String
    let endDate: Int
    let file: String
    let isModerated: Bool
}

struct EducationTypeLabel: Decodable {
    let id: Int
    let name: String
}

struct FreeReceptionTime: Decodable {
    let time: Int
}

struct HigherEducation: Decodable {
    let id: Int
    let university, specialization, qualification: String
    let startDate, endDate: Int?
    let untilNow, isModerated: Bool?
}

struct Rating: Decodable {
    let id: Int
    let name: String
    let value: Double
}

struct Specialization: Decodable {
    let id: Int
    let name: String
    let isModerated: Bool
}

struct WorkExperience: Decodable {
    let id: Int
    let organization, position: String
    let startDate: Double?
    let endDate: Double?
    let untilNow, isModerated: Bool?
}
