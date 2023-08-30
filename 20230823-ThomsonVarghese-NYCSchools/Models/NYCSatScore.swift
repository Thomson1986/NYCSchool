//
//  NYCSatScore.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/26/23.
//

import Foundation

struct NYCSatScore: Codable {
    
    let dbn: String?
    let schoolName: String?
    let satTestTakers: String?
    let satReadScore: String?
    let satMathScore: String?
    let satWritingScore: String?
    
    enum CodingKeys: String, CodingKey {

        case dbn
        case schoolName = "school_name"
        case satTestTakers = "num_of_sat_test_takers"
        case satReadScore = "sat_critical_reading_avg_score"
        case satMathScore = "sat_math_avg_score"
        case satWritingScore = "sat_writing_avg_score"
    }
}
