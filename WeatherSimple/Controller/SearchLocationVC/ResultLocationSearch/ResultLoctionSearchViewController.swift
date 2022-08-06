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
        
        print(searchLocation[indexPath.row])
        
        //MARK:- Save to Core data
        let newLocation = Location(context: context)
        newLocation.key = searchLocation[indexPath.row].Key
        newLocation.localizedName = searchLocation[indexPath.row].LocalizedName
        newLocation.countryID = searchLocation[indexPath.row].Country?.ID
        newLocation.countryLocalizedName = searchLocation[indexPath.row].Country?.LocalizedName
        newLocation.adminID = searchLocation[indexPath.row].AdministrativeArea?.ID
        newLocation.adminLocalizedName = searchLocation[indexPath.row].AdministrativeArea?.LocalizedName
        do {
            try context.save()
            print( "codata")
        } catch let error {
            print(error.localizedDescription)
            
        }
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
