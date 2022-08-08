//
//  ResultLoctionSearchViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import CoreData
protocol ResultLoctionSearchViewControllerDelegate {
    func tapLocation(searchLocation: SearchLocation)
}

class ResultLoctionSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var delegate:ResultLoctionSearchViewControllerDelegate?
    var searchLocation = [SearchLocation]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchTextField.becomeFirstResponder()
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ResultLocationSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    func configTextField(){
        searchTextField.delegate = self
        
    }
    
}
extension ResultLoctionSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultLocationSearchTableViewCell
        let location = searchLocation[indexPath.row].LocalizedName! + "," + (searchLocation[indexPath.row].Country?.LocalizedName)! + "," +
            (searchLocation[indexPath.row].Country?.ID)!
        cell.configCell(location: location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let value = searchLocation[indexPath.row]
        
        guard let key = value.Key,
              let localizedName = value.LocalizedName,
              let countryID = value.Country?.ID,
              let countryLocalizedName = value.Country?.LocalizedName,
              let adminID = value.AdministrativeArea?.ID,
              let adminLocalizedName = value.AdministrativeArea?.LocalizedName else {
            return
        }
        
        DataManager.shared.creatNewLocationCoreData(key: key, localizedName: localizedName, countryID: countryID, countryLocalizedName: countryLocalizedName, adminID: adminID, adminLocalizedName: adminLocalizedName)
        
        delegate?.tapLocation(searchLocation: searchLocation[indexPath.row])
    
        dismiss(animated: true, completion: nil)
    }
}
extension ResultLoctionSearchViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text, !text.isEmpty {
                APICaller.shared.autocompleteSearch(searchString: text) { (result) in
                    
                    self.searchLocation = result
                    self.tableView.reloadData()
                }
                
            } else {
                
            }
            tableView.reloadData()
        }

}
