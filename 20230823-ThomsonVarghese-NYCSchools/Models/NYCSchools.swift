//
//  NYCSchools.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import Foundation

struct NYCSchool: Codable {
    
    let dbn: String?
    let schoolName: String?
    let phoneNumber: String?
    let website: String?
    let addressLine: String?
    let city: String?
    let state: String?
    let zip: String?
    let latitude: String?
    let longitude: String?
    let overview: String?

    enum CodingKeys: String, CodingKey {

        case dbn
        case schoolName = "school_name"
        case phoneNumber = "phone_number"
        case website = "website"
        case addressLine = "primary_address_line_1"
        case city
        case state = "state_code"
        case zip
        case latitude
        case longitude
        case overview = "overview_paragraph"
    }
}
