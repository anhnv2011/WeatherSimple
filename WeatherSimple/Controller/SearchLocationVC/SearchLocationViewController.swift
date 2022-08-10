//
//  SearchLocationViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import EzPopup
import CoreData

protocol SearchLocationViewControllerDelegate {
    func choseLocation(searchLocation: SearchLocation) //from resultSearch
    func changeLocation(location: Location) // from favorite table
}

class SearchLocationViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var favoriteTableView: UITableView!
    
     
    var passdatatest = "test"
    //đối tương dung để truy vấn vào bộ nhớ
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: SearchLocationViewControllerDelegate?
    
    var arrLocation = [Location]()
    var arrWeather = [CurrentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextfield()
        fetchDataTableView()
        configTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("aaaaaaaaaaaa:\(arrWeather.count)")
    }
    func configTableView(){
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        
    }
    
    func fetchDataTableView(){
        do {
            self.arrLocation = try context.fetch(Location.fetchRequest())
            
            favoriteTableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
        
//        for num in self.arrLocation{
//            APICaller.shared.getDetailCurrentConditionWeather(locationId: num.key!) { (result) in
//                self.arrWeather.append(contentsOf: result)
//                print("1\(self.arrWeather)")
//                self.favoriteTableView.reloadData()
//            }
//        }
        
        
        print("2\(self.arrWeather)")
        //
        favoriteTableView.reloadData()
    }
    
    func configTextfield(){
        searchTextfield.delegate = self
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchResult(){
        let vc = ResultLoctionSearchViewController()
        //        let popVc = PopupViewController(contentController: vc, position: .offsetFromView(CGPoint(x: 0, y: searchTextfield.frame.height), searchTextfield), popupWidth: view.frame.width - 40, popupHeight: view.bounds.height/2)
        //        let popVc = PopupViewController(contentController: vc, position: ., popupWidth: <#T##CGFloat?#>, popupHeight: <#T##CGFloat?#>)
        //        present(popVc, animated: true, completion: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension SearchLocationViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTextfield {
            searchResult()
        }
    }
    
}

extension SearchLocationViewController:ResultLoctionSearchViewControllerDelegate{
    func tapLocation(searchLocation: SearchLocation) {
        fetchDataTableView()
        
        delegate?.choseLocation(searchLocation: searchLocation)
    }
    
}

extension SearchLocationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        
        if arrWeather.count > 0 {
            let location = arrLocation[indexPath.row]
            var type = ""
            var temperate = ""
            let value = DataManager.shared.getCurrentMeasureType()
            
            if value == MeasureType.metric.rawValue {
                
                type = "°C"
                temperate = String((arrWeather[indexPath.row].Temperature?.Metric?.Value)!)
            } else if value == MeasureType.england.rawValue {
                temperate = String((arrWeather[indexPath.row].Temperature?.Imperial?.Value)!)
                type = "°F"
            } else {
                temperate = String((arrWeather[indexPath.row].Temperature?.Metric?.Value)!)
                type = "°C"
                
            }
                    let image = String(arrWeather[indexPath.row].WeatherIcon!)
            print("sdadasdasdasdasdasd \(image)")
            cell.configFavoriteTableViewCell(location: location.localizedName!, country: location.countryLocalizedName!, image: image, temperature: temperate, type: type)
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoriteTableView.deselectRow(at: indexPath, animated: true)
        delegate?.changeLocation(location: arrLocation[indexPath.row])
       
        let key = arrLocation[indexPath.row].key
        DataManager.shared.newLocationkey = key!
        NotificationCenter.default.post(name: Notification.Name.newLocation,object: self, userInfo: ["location" : "testAny"])
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            
            let locationDelete = self.arrLocation[indexPath.row]
            
            DataManager.shared.deleteLocationCoreData(locationDelete: locationDelete)
            self.fetchDataTableView()
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    
}
