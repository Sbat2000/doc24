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
    @Published var doctors = [DoctorModel]()
    
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
                self.doctors = doctors
            })
            .store(in: &cancellables)
    }
}
