//
//  NYCSchoolService.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import UIKit

protocol NYCSchoolRepository {
    func fetchSchools<T: Codable>(_ t: T.Type, url: String, completion: @escaping ((T?) -> Void))
}

class NYCSchoolService: NSObject {
}

extension NYCSchoolService: NYCSchoolRepository {
    
    func fetchSchools<T: Codable>(_ t: T.Type, url: String, completion: @escaping ((T?) -> Void)) {
        
        guard let requestURL = URL(string: url) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: requestURL)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let responseData = try? JSONDecoder().decode(T.self, from: data)
            if let responseData = responseData {
                completion(responseData)
            }
            else {
                completion(nil)
            }
        }.resume()
    }
}
