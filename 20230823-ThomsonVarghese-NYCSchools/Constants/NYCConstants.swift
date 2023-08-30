//
//  NYCConstants.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import Foundation

struct NYCConstants {
    
    static var schoolURL: String {
        return "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    }
    static var satURL: String {
        return "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    }

}

//TODO - Can add more specific error cases
enum NYCError: Error {
    case unknownError
    case invalidResponse
}

enum ResponseType {
    
    case success([NYCSchool])
    case error
}
