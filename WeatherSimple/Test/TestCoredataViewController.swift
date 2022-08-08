//
//  TestCoredataViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit
import CoreData
class TestCoredataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrData = [Location]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

//        let newLocation = Location(context: context)
//        newLocation.key = "1233"
//        newLocation.localizedName = "ha noi3"
//        newLocation.countryID = "VN3"
//        newLocation.countryLocalizedName = "Viet nam3"
//        newLocation.adminID = "456w"
//        newLocation.adminLocalizedName = "ha noi3"
//        do {
//            try context.save()
//            print( "codata")
//        } catch let error {
//            print(error.localizedDescription)
//            
//        }
//        tableView.delegate = self
//        tableView.dataSource = self
//
//
//        //get data
//        fetchData()
        DataManager.shared.changeMeasureType(type: .metric)
        
        let value = DataManager.shared.getCurrentMeasureType()
        print(value)
        
        
    }

    func fetchData(){
        do {
            self.arrData = try context.fetch(Location.fetchRequest())
            print(arrData.count)
            print(arrData)
            tableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
extension TestCoredataViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = arrData[indexPath.row].localizedName
        cell.detailTextLabel?.text = arrData[indexPath.row].key
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            
            let userDelete = self.arrData[indexPath.row]
            self.context.delete(userDelete)
            self.fetchData()
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
            
//            let alert = UIAlertController(title: "Edit Phone", message: nil, preferredStyle: .alert)
//            alert.addTextField { (textfield) in
//                textfield.text = self.arrData[indexPath.row].phone
//
//            }
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
//                //cập nhật phone
//                let itemUpdate = self.arrData[indexPath.row]
//                itemUpdate.phone = alert.textFields![0].text
//
//                do {
//                    try self.context.save()
//                    self.fetchData()
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }))
//            self.present(alert, animated: true, completion: nil)
            
        }
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}
