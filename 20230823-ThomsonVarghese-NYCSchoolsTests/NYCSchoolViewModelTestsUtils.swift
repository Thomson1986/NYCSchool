//
//  WeatherTestUtils.swift
//  WeatherAppTests
//
//  Created by Thomson Varghese on 6/14/23.
//

import Foundation

@testable import _0230823_ThomsonVarghese_NYCSchools

//Utils class to
//1.Read mock response
final class NYCSchoolViewModelTestsUtils {
    
    //Helper function to  read file from bundle
    static func readJsonData(fromFile fileName: String) -> Data? {
        let resourceName = fileName.components(separatedBy: ".").first
        let fileType = fileName.components(separatedBy: ".").last
        do {
            if let filePath = Bundle.main.path(forResource: resourceName, ofType: fileType) {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    //Function to get mocked school list response
    static func readSchoolList() -> [NYCSchool]? {
        
        guard let response = NYCSchoolViewModelTestsUtils.readJsonData(fromFile: "SchoolListResponse.json"),
              let schoolListResponse = try? JSONDecoder().decode([NYCSchool].self, from: response) else {
            return nil
        }
        return schoolListResponse
    }
    
    //Function to get mocked city response
    static func readSATDetails() -> [NYCSatScore]? {

        guard let response = NYCSchoolViewModelTestsUtils.readJsonData(fromFile: "SatResponse.json"),
              let satResponse = try? JSONDecoder().decode([NYCSatScore].self, from: response) else {
            return nil
        }
        return satResponse
    }
}
