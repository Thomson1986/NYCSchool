//
//  NYCSchoolViewModel.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import UIKit

//View loading states
enum ViewState {
    case loading
    case success
    case error
}

protocol NYCSchoolViewState {

    //View state properties
    var updateState: ((ViewState) -> Void)? { get set }
}

protocol NYCSchoolViewModelProtocol: NYCSchoolViewState {
    
    func fetchSchoolList()
    func filterWith(text: String)
}

class NYCSchoolViewModel: NYCSchoolViewModelProtocol {
    
    private (set) var schoolList = [NYCSchool]()
    private var duplicateSchoolList = [NYCSchool]()
    
    var schoolListService: NYCSchoolRepository
    var updateState: ((ViewState) -> Void)?

    init(schoolListService: NYCSchoolRepository) {
        self.schoolListService = schoolListService
    }
    
    func fetchSchoolList() {
        
        updateState?(ViewState.loading)
        schoolListService.fetchSchools([NYCSchool].self, url: NYCConstants.schoolURL) { [weak self] schoolList in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                if let schoolList = schoolList {
                    self.schoolList = schoolList
                    self.duplicateSchoolList = schoolList
                    self.updateState?(ViewState.success)
                    return
                }
                else {
                    self.updateState?(ViewState.error)
                }
            }
        }
    }
    
    func filterWith(text: String) {
        if text.isEmpty {
            schoolList = duplicateSchoolList
        }
        else {
            schoolList = duplicateSchoolList.filter{$0.schoolName?.contains(text) ?? false}
        }
        updateState?(ViewState.success)
    }
}
