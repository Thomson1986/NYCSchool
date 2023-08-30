//
//  NYCSchoolCell.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import UIKit

class NYCSchoolCell: UITableViewCell {

    @IBOutlet weak var schoolView: UIView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolAddressLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        schoolView.layer.cornerRadius = 10.0
        schoolView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(data: NYCSchool) {
        schoolNameLabel.text = data.schoolName ?? ""
        schoolAddressLabel.text = data.displayAddress
    }

}
