//
//  _0230823_ThomsonVarghese_NYCSchoolsTests.swift
//  20230823-ThomsonVarghese-NYCSchoolsTests
//
//  Created by Thomson Varghese on 8/23/23.
//

import XCTest
@testable import _0230823_ThomsonVarghese_NYCSchools

class NYCSchoolViewModelTests: XCTestCase {

    var schoolViewModel: NYCSchoolViewModel!
    var schoolService: NYCSchoolRepository!
    
    override func setUpWithError() throws {
        
        schoolService = MockService()
        schoolViewModel = NYCSchoolViewModel(schoolListService: schoolService)
    }

    func testNotNil() throws {
        
        XCTAssertNotNil(schoolService, "School Service nil")
        XCTAssertNotNil(schoolViewModel, "School VM nil")
    }
    
    func testSchoolListSuccessViewState() {
        
        schoolViewModel.updateState = { status in
            XCTAssertTrue(status == .loading)
        }
        MockService.mockResponseType = .success
        schoolViewModel.fetchSchoolList()
        schoolViewModel.updateState = { status in
            XCTAssertTrue(status == .success)
        }
    }
    
    func testSchoolListSuccessResponse() {
        
        MockService.mockResponseType = .success
        schoolViewModel.fetchSchoolList()
        schoolViewModel.updateState = { [weak self] status in
            XCTAssertTrue(status == .success)
            XCTAssertTrue(self?.schoolViewModel.schoolList.count == 1)
        }
    }
    
    func testSchoolListErrorResponse() {
        
        MockService.mockResponseType = .error
        schoolViewModel.fetchSchoolList()
        schoolViewModel.updateState = { status in
            XCTAssertTrue(status == .error)
        }
    }
    
    func testSchoolListFilter() {
        
        MockService.mockResponseType = .success
        schoolViewModel.fetchSchoolList()
        schoolViewModel.filterWith(text: "Clinton")
        schoolViewModel.updateState = { [weak self] status in
            
            XCTAssertTrue(status == .success)
            XCTAssertTrue(self?.schoolViewModel.schoolList.count == 1)
        }
    }
    
    func testSchoolListFilterNoMatch() {
        
        MockService.mockResponseType = .success
        schoolViewModel.fetchSchoolList()
        schoolViewModel.filterWith(text: "ABCDEDWS")
        schoolViewModel.updateState = { [weak self] status in
            
            XCTAssertTrue(status == .success)
            XCTAssertTrue(self?.schoolViewModel.schoolList.count == 0)
        }
    }
    
    func testSchoolListFilterEmpty() {
        
        MockService.mockResponseType = .success
        schoolViewModel.fetchSchoolList()
        schoolViewModel.filterWith(text: "")
        schoolViewModel.updateState = { [weak self] status in
            
            XCTAssertTrue(status == .success)
            XCTAssertTrue(self?.schoolViewModel.schoolList.count == 1)
        }
    }
}

class MockService: NYCSchoolRepository {
    
    enum MockResponseType {
        case success
        case error
    }
    static var mockResponseType = MockResponseType.error
    func fetchSchools<T>(_ t: T.Type, url: String, completion: @escaping ((T?) -> Void)) where T : Decodable, T : Encodable {
        
        guard let response = NYCSchoolViewModelTestsUtils.readSchoolList() else {
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
