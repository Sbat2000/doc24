//
//  DoctorsDataLoader.swift
//  Doc
//
//  Created by Aleksandr Garipov on 15.03.2024.
//

import Foundation
import Combine

final class DoctorsDataLoader {
    private static let endpoint = URL(string: "https://api.jsonbin.io/v3/b/655b754e0574da7622c94aa4")!
    
    func fetch(_ endpoint: URL = endpoint) -> AnyPublisher<[User], Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: endpoint)
            .map { $0.data }
            .decode(type: Doctors.self, decoder: decoder)
            .map { $0.record }
            .map { $0.data }
            .map { $0.users }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
