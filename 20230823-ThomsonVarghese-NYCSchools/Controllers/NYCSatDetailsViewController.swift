//
//  NYCSatDetailsViewController.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/26/23.
//

import UIKit

class NYCSatDetailsViewController: UIViewController {

    var viewModel: NYCSchoolSatDetailsViewModel?
    var school: NYCSchool?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "School Sat Details"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        setupCallBacks()
        
        viewModel?.fetchSchoolSatDetails()
    }
    
    private func setupCallBacks() {
        
        viewModel?.updateState = { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .loading:
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            case .success:
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            case .error:
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }

}

extension NYCSatDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "satCell") as? NYCSatCell else { return UITableViewCell() }
        
        cell.setup(school: school, sat: viewModel?.score)
        return cell
    }

}
