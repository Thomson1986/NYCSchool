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
        
        schoolService =
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class MockService: NYCSchoolRepository {
    
    func fetchSchools<T>(_ t: T.Type, url: String, completion: @escaping ((T?) -> Void)) where T : Decodable, T : Encodable {
        
    }
    
    
}
