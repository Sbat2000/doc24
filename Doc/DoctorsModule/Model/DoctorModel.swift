//
//  DoctorModel.swift
//  Doc
//
//  Created by Aleksandr Garipov on 16.03.2024.
//

import Foundation

struct DoctorModel: Identifiable {
    let id: String
    let firstName: String
    let patronymic: String
    let lastName: String
    let gender: String
    let rank: Int
    let avatar: String?
    let prices: [String:Int]
    let position: String?
    let experience: String
    let minPrice: String
    let isFavorite: Bool
    let nearestReceptionTime: Double?
    let educationTypeLabel: String
    let category: String
    let specialization: String
    let currentPosition: String
    let descriptions: String
}
