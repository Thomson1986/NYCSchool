//
//  NYCSatCell.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/26/23.
//

import UIKit

class NYCSatCell: UITableViewCell {
    
    @IBOutlet weak var schoolSatView: UIView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolOverviewLabel: UILabel!
    @IBOutlet weak var schoolSatLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        schoolSatView.layer.cornerRadius = 10.0
        schoolSatView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(school: NYCSchool?, sat: String?) {
        schoolNameLabel.text = school?.schoolName ?? ""
        schoolOverviewLabel.text = school?.overview ?? ""
        schoolSatLabel.text = sat ?? ""
    }

}

