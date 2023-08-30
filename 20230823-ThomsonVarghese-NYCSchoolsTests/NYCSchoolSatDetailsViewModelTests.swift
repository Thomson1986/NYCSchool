//
//  NYCSchoolSatDetailsViewModelTests.swift
//  20230823-ThomsonVarghese-NYCSchoolsTests
//
//  Created by Thomson Varghese on 8/28/23.
//

import XCTest
@testable import _0230823_ThomsonVarghese_NYCSchools

class NYCSchoolSatDetailsViewModelTests: XCTestCase {

    var schoolDetailViewModel: NYCSchoolSatDetailsViewModel!
    var satService: SATMockService!
    
    override func setUpWithError() throws {
        
        satService = SATMockService()
        schoolDetailViewModel = NYCSchoolSatDetailsViewModel()
        schoolDetailViewModel.schoolService = satService
        schoolDetailViewModel.school = NYCSchool(dbn: "29Q283", schoolName: "PREPARATORY ACADEMY FOR WRITERS: A COLLEGE BOARD", phoneNumber: "12312312", website: "123", addressLine: "124", city: "Irving", state: "TX", zip: "62532", latitude: "12.22", longitude: "23.23", overview: "school details")
        
    }

    func testNotNil() throws {
        
        XCTAssertNotNil(satService, "Service nil")
        XCTAssertNotNil(schoolDetailViewModel, "School Details VM nil")
    }
    
    func testSchollSatServiceSuccessViewState() {
        
        schoolDetailViewModel.updateState = { status in
            XCTAssertTrue(status == .loading)
        }
        SATMockService.mockResponseType = .success
        schoolDetailViewModel.fetchSchoolSatDetails()
        schoolDetailViewModel.updateState = { status in
            XCTAssertTrue(status == .success)
        }
    }
    
    func testSchoolListSuccessResponse() {
        
        SATMockService.mockResponseType = .success
        
        schoolDetailViewModel.fetchSchoolSatDetails()
        schoolDetailViewModel.updateState = { status in
            XCTAssertTrue(status == .success)
        }
    }
}

class SATMockService: NYCSchoolRepository {
    
    enum MockResponseType {
        case success
        case error
    }
    static var mockResponseType = MockResponseType.error
    func fetchSchools<T>(_ t: T.Type, url: String, completion: @escaping ((T?) -> Void)) where T : Decodable, T : Encodable {
        
        guard let response = NYCSchoolViewModelTestsUtils.readSATDetails() else {
            completion(nil)
            return
        }
        switch MockService.mockResponseType {
        case .success:
            completion(response as? T)
        default:
            completion(nil)
        }
    }
    
    
}
