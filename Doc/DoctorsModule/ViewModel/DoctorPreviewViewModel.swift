//
//  DoctorPreviewViewModel.swift
//  Doc
//
//  Created by Aleksandr Garipov on 15.03.2024.
//

import SwiftUI
import Combine

class DoctorPreviewViewModel: ObservableObject {
    
    //MARK: - Public properties
    private var rawDoctors = [DoctorModel]() {
        didSet {
            doctors = rawDoctors
        }
    }
    @Published var doctors = [DoctorModel]()
    @Published var searchText = ""
    
    private var dataLoader = DoctorsDataLoader()
    private var cancellables = Set<AnyCancellable>()
    
    func loadUsers() {
        dataLoader.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Ошибка при загрузке данных: \(error)")
                }
            }, receiveValue: { users in
                let doctors = DataConverter.convertUsersToDoctors(users: users)
                self.rawDoctors = doctors
            })
            .store(in: &cancellables)
    }
    
    func searchDoctors() {
        guard !searchText.isEmpty else {
            doctors = rawDoctors
            return
        }
        
        doctors = rawDoctors.filter { doctor in
            doctor.lastName.lowercased().contains(searchText.lowercased()) ||
            doctor.firstName.lowercased().contains(searchText.lowercased()) ||
            doctor.patronymic.lowercased().contains(searchText.lowercased())
        }
    }
}

