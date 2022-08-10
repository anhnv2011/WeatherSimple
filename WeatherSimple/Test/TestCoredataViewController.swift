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
    
    //   // var barchart = BarChartView()
    //    var chartview = CombinedChartView()
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
        
        //
        //                let c = BarChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width))
        //                view.addSubview(c)
        //        //        c.fitBars = true
        //                        var entry = [BarChartDataEntry]()
        //                        for x in 0...3 {
        //                            //            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6)))
        //                            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6), icon: UIImage(named: "\(x)")))
        //                        }
        //
        //                        let set = BarChartDataSet(entries: entry, label: "test")
        //                        set.colors = [UIColor.brown]
        //
        //                        let data = BarChartData(dataSet: set)
        //                c.data = data
        //        let columnTitles = ["Max", "Til", "Clo", "Tol"]
        //                let formatter = IndexAxisValueFormatter(values: columnTitles)
        //                c.xAxis.valueFormatter = formatter
        
        
        //        let chartview = CombinedChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width))
        //        view.addSubview(chartview)
        //        chartview.delegate = self
        //
        //
        //        var entry = [BarChartDataEntry]()
        //        for x in 0...4 {
        //            //            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6)))
        //            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6), icon: UIImage(named: "\(x)")))
        //        }
        //
        //        let set = BarChartDataSet(entries: entry, label: "test")
        //        set.colors = [UIColor.brown]
        //
        //        let bardata = BarChartData(dataSet: set)
        //        let groupSpace = 0.06
        //        let barSpace = 0.04
        //        let barWidth = 0.9
        //
        //        bardata.barWidth = barWidth
        //        bardata.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        //
        //        var linerentry = [ChartDataEntry]()
        //
        //        for x in 0...4{
        //            linerentry.append(ChartDataEntry(x: Double(x), y: Double(x+2)))
        //        }
        //        let linerset = LineChartDataSet(entries: linerentry, label: "min")
        //        //linerset.colors = ChartColorTemplates.material()
        //        let linerdata = LineChartData(dataSet: linerset)
        //
        //        let combinedata = CombinedChartData()
        //        combinedata.lineData = linerdata
        //        combinedata.barData = bardata
        //
        //        let columnTitles = ["Max", "Til", "Clo", "Tol", "aaa", "bb"]
        //        let formatter = IndexAxisValueFormatter(values: columnTitles)
        //        chartview.xAxis.valueFormatter = formatter
        ////        chartview.setVisibleXRange(minXRange: 4, maxXRange: 4)
        ////        chartview.xAxis.granularity = 1
        ////
        ////
        ////        let xAxis = chartview.xAxis
        ////        xAxis.labelPosition = .bothSided
        ////        xAxis.axisMinimum = 0
        ////        xAxis.granularity = 1
        //        //        xAxis.valueFormatter = self
        //
        //
        //        chartview.chartDescription.enabled = false
        //
        //        chartview.drawBarShadowEnabled = false
        //        chartview.highlightFullBarEnabled = false
        //        chartview.drawOrder = [DrawOrder.bar.rawValue,
        //                                       DrawOrder.line.rawValue
        //                ]
        //
        //
        //                let l = chartview.legend
        //                l.wordWrapEnabled = true
        //                l.horizontalAlignment = .center
        //                l.verticalAlignment = .bottom
        //                l.orientation = .horizontal
        //                l.drawInside = false
        //                //        chartView.legend = l
        //
        //                let rightAxis = chartview.rightAxis
        //                rightAxis.axisMinimum = 0
        //
        //                let leftAxis = chartview.leftAxis
        //                leftAxis.axisMinimum = 0
        //
        //                let xAxis = chartview.xAxis
        //                xAxis.labelPosition = .bothSided
        //                xAxis.axisMinimum = 0
        //                xAxis.granularity = 1
        //        chartview.data = combinedata
        //        chartview.xAxis.axisMaximum = combinedata.xMax + 0.25
        //
        //        chartview.notifyDataSetChanged()
        //
        
        
        
        // testChart()
        //test2()
        //groupbar()
        simpleGroupChart()
    }
    func simpleGroupChart(){
        let barchart = BarChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width))
        view.addSubview(barchart)
        //        c.fitBars = true
        var entry = [BarChartDataEntry]()
        for x in 0...3 {
            //            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6)))
            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6), icon: UIImage(named: "\(x)")))
        }
        var entry2 = [BarChartDataEntry]()
        for x in 0...3 {
            //            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6)))
            entry2.append(BarChartDataEntry(x: Double(x), y: Double(x + 3)))
        }
        
        let set = BarChartDataSet(entries: entry, label: "test")
        set.colors = [UIColor.brown]
        let set2 = BarChartDataSet(entries: entry2, label: "test2")
        set2.colors = [UIColor.red]
        
        let data = BarChartData(dataSets: [set, set2])
        
        
        //        let groupSpace = 0.3
        //        let barSpace = 0.05
        //        let barWidth = 0.3
        
        //        data.barWidth = barWidth
        
        // make this BarData object grouped
        //        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        
        // (0.2 + 0.03) * 2 + 0.54 = 1.00
        let groupSpace = 0.54
        let barSpace = 0.03
        let barWidth = 0.2
        data.barWidth = barWidth
        
        barchart.xAxis.axisMinimum = Double(0)
        barchart.xAxis.axisMaximum = Double(0) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(4)  // group count : 2
        data.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        
        barchart.data = data
        
        let x_Axis = barchart.xAxis
        x_Axis.centerAxisLabelsEnabled = true
        x_Axis.granularity = 1
        barchart.xAxis.labelPosition = .top
        
        let columnTitles = ["Max", "Til", "Clo", "Tol"]
        let formatter = IndexAxisValueFormatter(values: columnTitles)
        barchart.xAxis.valueFormatter = formatter
        
        //        barchart.animate(yAxisDuration: 0.8, easingOption: .easeInCubic)
        
        
        
    }
    
    func groupbar(){
        
        let barchart = BarChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width))
        view.addSubview(barchart)
        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
        let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0]
        barchart.delegate = self
        barchart.noDataText = "You need to provide data for the chart."
        barchart.chartDescription.text = "sales vs bought "
        //legend
        let legend = barchart.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let xaxis = barchart.xAxis
        //xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barchart.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        barchart.rightAxis.enabled = false
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: unitsSold[i])
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: unitsBought[i])
            dataEntries1.append(dataEntry1)
            
            //stack barchart
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [self.unitsSold[i],self.unitsBought[i]], label: "groupChart")
            
            
            
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Unit sold")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Unit Bought")
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        
        
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        let startYear = 0
        
        
        chartData.barWidth = barWidth;
        barchart.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barchart.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barchart.notifyDataSetChanged()
        
        barchart.data = chartData
        
        
        

        
        //background color
        barchart.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //chart animation
        barchart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
    }
    
    func test2(){
        let chartview = CombinedChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width))
        view.addSubview(chartview)
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [2.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 17.0, 2.0, 4.0, 5.0, 4.0]
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()
        
        for i in 0..<months.count {
            
            yVals1.append(ChartDataEntry(x: Double(i), y: unitsSold[i]))
            yVals2.append(BarChartDataEntry(x: Double(i), y: unitsSold[i]))
            
        }
        
        let lineChartSet = LineChartDataSet(entries: yVals1, label: "line")
        let barChartSet: BarChartDataSet = BarChartDataSet(entries: yVals2, label: "bar")
        
        let linedata = LineChartData(dataSet: lineChartSet)
        let bardata = BarChartData(dataSet: barChartSet)
        let data = CombinedChartData()
        data.lineData = linedata
        data.barData = bardata
        
        chartview.data = data
        
        
    }
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    func testChart(){
        let chartView = CombinedChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width))
        view.addSubview(chartView)
        chartView.delegate = self
        
        //        chartView.chartDescription.enabled = false
        //
        //        chartView.drawBarShadowEnabled = false
        //        chartView.highlightFullBarEnabled = false
        //        chartView.drawOrder = [DrawOrder.bar.rawValue,
        //                               DrawOrder.line.rawValue
        //        ]
        //
        //
        //        let l = chartView.legend
        //        l.wordWrapEnabled = true
        //        l.horizontalAlignment = .center
        //        l.verticalAlignment = .bottom
        //        l.orientation = .horizontal
        //        l.drawInside = false
        //        //        chartView.legend = l
        //
        //        let rightAxis = chartView.rightAxis
        //        rightAxis.axisMinimum = 0
        //
        //        let leftAxis = chartView.leftAxis
        //        leftAxis.axisMinimum = 0
        //
        //        let xAxis = chartView.xAxis
        //        xAxis.labelPosition = .bothSided
        //        xAxis.axisMinimum = 0
        //        xAxis.granularity = 1
        //        //        xAxis.valueFormatter = self
        //
        
        let entries = (0...3).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Line DataSet")
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        // set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left
        let linedata = LineChartData(dataSet: set)
        
        let entries1 = (0...3).map { _ -> BarChartDataEntry in
            return BarChartDataEntry(x: 0, y: Double(arc4random_uniform(25) + 25))
        }
        //        let entries2 = (0...3).map { _ -> BarChartDataEntry in
        //            return BarChartDataEntry(x: 0, yValues: [Double(arc4random_uniform(13) + 12), Double(arc4random_uniform(13) + 12)])
        //        }
        
        var entry = [BarChartDataEntry]()
        for x in 0...3 {
            //            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6)))
            entry.append(BarChartDataEntry(x: Double(x), y: Double(x + 6), icon: UIImage(named: "\(x)")))
        }
        
        let set1 = BarChartDataSet(entries: entry, label: "test")
        set1.setColor(UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1))
        set1.valueTextColor = UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1)
        set1.valueFont = .systemFont(ofSize: 10)
        set1.axisDependency = .left
        
        let bardata = BarChartData(dataSet: set1)
        
        let groupSpace = 0.06
        let barSpace = 0.04 // x2 dataset
        let barWidth = 0.9 // x2 dataset
        
        bardata.barWidth = barWidth
        bardata.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        let data = CombinedChartData()
        data.lineData = linedata
        data.barData = bardata
        
        chartView.xAxis.axisMaximum = data.xMax + 0.25
        
        chartView.data = data
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func actionbutton(_ sender: Any) {
        present(tViewController(), animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
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
//extension TestCoredataViewController: AxisValueFormatter {
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return months[Int(value) % months.count]
//    }
//}
