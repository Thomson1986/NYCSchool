//
//  NYCSchoolSatDetailsViewModel.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/26/23.
//

import Foundation

protocol NYCSchoolSatDetailsViewModelProtocol: NYCSchoolViewState {
    
    var score: String { get }
    func fetchSchoolSatDetails()
}

class NYCSchoolSatDetailsViewModel: NYCSchoolSatDetailsViewModelProtocol {
    
    var updateState: ((ViewState) -> Void)?
    
    var school: NYCSchool?
    var satScore: NYCSatScore?
    var schoolService: NYCSchoolRepository?

    var score: String {
        
        guard let satScore = satScore else {
            return "SAT Score Not Available"
        }
        
        let takers = satScore.satTestTakers ?? ""
        let readScore = satScore.satReadScore ?? ""
        let writeScore = satScore.satWritingScore ?? ""
        let mathScore = satScore.satMathScore ?? ""
        return "Total Test Takers: \(takers) \n Read Score: \(readScore) \n Write Score: \(writeScore) \n Math Score: \(mathScore)"
    }
    
    func fetchSchoolSatDetails() {
        
        guard let dbn = school?.dbn else {
            return
        }
        updateState?(ViewState.loading)
        schoolService?.fetchSchools([NYCSatScore].self, url: NYCConstants.satURL.appending("?dbn=\(dbn)")) { [weak self] satData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                if let satData = satData {
                    self.satScore = satData.first
                    self.updateState?(ViewState.success)
                    return
                }
                else {
                    self.updateState?(ViewState.error)
                }
            }
        }
        
    }
}
