//
//  NYCExtension.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import Foundation

extension NYCSchool {
    
    //To create address in multi lines
    var displayAddress: String {
        return "\(self.addressLine ?? "" ) \n \(self.city ?? ""), \(self.state ?? "") \n \(self.zip ?? "")"
        
    }
}
