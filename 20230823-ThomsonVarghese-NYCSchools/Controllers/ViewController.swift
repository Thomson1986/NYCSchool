//
//  ViewController.swift
//  20230823-ThomsonVarghese-NYCSchools
//
//  Created by Thomson Varghese on 8/23/23.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let viewModel = NYCSchoolViewModel(schoolListService: NYCSchoolService())
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "School List"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        errorLabel.isHidden = true
        setupCallBacks()
        
        viewModel.fetchSchoolList()
    }
    
    private func setupCallBacks() {
        
        viewModel.updateState = { [weak self ]status in
            guard let self = self else { return }
            switch status {
            case .loading:
                self.errorLabel.isHidden = true
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            case .success:
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.errorLabel.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            case .error:
                self.tableView.isHidden = true
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.errorLabel.isHidden = false
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        searchBar.resignFirstResponder()
        searchBar.searchTextField.text = ""
        viewModel.fetchSchoolList()
    }
    
    @objc func callAction(_ button: UIButton) {
        if viewModel.schoolList.count > button.tag {
            let school = viewModel.schoolList[button.tag]
            let phoneNumber = school.phoneNumber?.filter("0123456789.".contains)
            if let url = URL(string: "tel://\(String(describing: phoneNumber))"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func mapAction(_ button: UIButton) {
        guard viewModel.schoolList.count > button.tag,
              let latitude = Double(viewModel.schoolList[button.tag].latitude ?? "0.0"),
              let longitude = Double(viewModel.schoolList[button.tag].longitude ?? "0.0") else { return }
        
        let school = viewModel.schoolList[button.tag]
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = school.schoolName
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schoolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell") as? NYCSchoolCell else { return UITableViewCell() }
        
        cell.callButton.tag = indexPath.row
        cell.mapButton.tag = indexPath.row
        cell.callButton.addTarget(self, action: #selector(callAction(_:)), for: .touchUpInside)
        cell.mapButton.addTarget(self, action: #selector(mapAction(_:)), for: .touchUpInside)
        cell.setup(data: viewModel.schoolList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let school = viewModel.schoolList[indexPath.row]
        let satViewModel = NYCSchoolSatDetailsViewModel()
        satViewModel.school = school
        satViewModel.schoolService = NYCSchoolService()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let satDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "NYCSatDetailsViewController") as! NYCSatDetailsViewController
        satDetailsViewController.viewModel = satViewModel
        satDetailsViewController.school = school
        self.navigationController?.pushViewController(satDetailsViewController, animated: true)
    }
}


extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterWith(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
