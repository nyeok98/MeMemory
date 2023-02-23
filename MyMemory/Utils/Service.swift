//
//  Service.swift
//  MyMemory
//
//  Created by 신동녘 on 2023/02/23.
//

import Foundation
import FirebaseDatabase

protocol FireBaseServiceProtocol {
    func fetchData(completion: @escaping (Result<[Day], Error>) -> Void)
}

final class FireBaseService: FireBaseServiceProtocol {
    
    let db = Database.database().reference().child("Day")
    
    func fetchData(completion: @escaping (Result<[Day], Error>) -> Void) {
        db.observeSingleEvent(of: .value) { snapshot, err  in
            guard let snapData = snapshot.value as? [String: Any] else { return }
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do {
                let decoder = JSONDecoder()
                let dayList = try decoder.decode([Day].self, from: data)
                completion(.success(dayList))
            } catch {
                print(err ?? "")
            }
        }
    }
}
