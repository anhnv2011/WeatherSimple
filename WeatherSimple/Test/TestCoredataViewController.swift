//
//  TestCoredataViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import Charts

class TestCoredataViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var tableView: UITableView!
    var arrData = [Location]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var next12hoursData:[Next12] = []
    
   // var barchart = BarChartView()
    var chartview = CombinedChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        2022-08-07T11:59:00+07:00
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
//        DataManager.shared.changeMeasureType(type: .metric)
//
//        let value = DataManager.shared.getCurrentMeasureType()
//        print(value)
        
//        getdata()
        
//        var dateString = "2022-08-07T11:59:00+07:00"
//        let dateFormatt = DateFormatter()
//        dateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let date = dateFormatt.date(from: dateString)
//
//        let stringformat = DateFormatter()
//        stringformat.dateFormat = "dd.MM.yy"
//        let currentdate = stringformat.string(from: date!)
        
        chartview.delegate = self
        //barchart.delegate = self
    
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topview.addSubview(chartview)
        chartview.frame = topview.bounds
        var entry = [BarChartDataEntry]()
        for x in 1...6 {
            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6)))
        }
        
        let set = BarChartDataSet(entries: entry, label: "test")
        set.colors = [UIColor.brown]
        let data = BarChartData(dataSet: set)
        
        var linerentry = [ChartDataEntry]()
        
        for x in 1...6{
            linerentry.append(ChartDataEntry(x: Double(x), y: Double(x+2)))
        }
        let linerset = LineChartDataSet(entries: linerentry, label: "min")
        //linerset.colors = ChartColorTemplates.material()
        let linerdata = LineChartData(dataSet: linerset)
        
        let combinedata = CombinedChartData()
        combinedata.lineData = linerdata
        combinedata.barData = data
        chartview.data = combinedata
      //  chartview.notifyDataSetChanged()
        
    }
    func getdata(){
        guard let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/353412?apikey=90LKUI4g3wxlc1GAd1Vh1tqFVc1KZvvG&details=true&metric=true") else {

                return
             }
             print(url)
             Alamofire.request(url).responseJSON(completionHandler: { (response) in
     
                 guard let value = response.result.value else {
                     print(APIError.error("Something wrong"))
                     return
                 }
     
                 let dataJson = JSON(value).arrayValue
                 let dataResult = dataJson.map({Next12($0)})
                self.next12hoursData = dataResult
                print(self.next12hoursData)
             })

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
