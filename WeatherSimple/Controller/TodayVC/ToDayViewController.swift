//
//  ToDayViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import SideMenu
import CoreLocation
import Alamofire
import SwiftyJSON


class ToDayViewController: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    let locationManager = CLLocationManager()
    let circleView = CircleView()
    let currentLocationURl = DataManager.shared.cacheFileURL(fileName: "currentlocation.json")
    
    var currentLocation = [CurrentLocation]()
    var next12hoursData = [Next12]()
    
    
    
    var searchVc:SearchLocationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeCurrentLocation()
        configureCollectionView()
        
        print(view.bounds.width)
        print(view.bounds.height)
        let settingvc = SettingViewController()
        settingvc.delegate = self
        
        //        APICaller.shared.getDayNightDataMetric(locationkey: "353412") { (result) in
        //            print(result)
        //        }
        
        // NotificationCenter.default.addObserver(self, selector: #selector(fetNewData), name: .newLocation, object: nil)
        //        NotificationCenter.default.addObserver(forName: .newLocation, object: nil, queue: OperationQueue.main) { (notification) in
        //
        //            print("test")
        //            let key = DataManager.shared.newLocationkey
        //            APICaller.shared.getDetailCurrentConditionWeather(locationId: key) { (currentResult) in
        //                self.currentLocation = currentResult
        //                DataManager.shared.currentLocationData = currentResult
        //                self.collectionView.reloadData()
        //            }
        //            APICaller.shared.getnex12htWeatherMetric(locationId: key) { (next12result) in
        //                self.next12hoursData = next12result
        //                DataManager.shared.next12hData = next12result
        //                self.collectionView.reloadData()
        //            }
        
        //        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetNewData(notification:)), name: .newLocation, object: nil)
        
    }
    
    
    @objc func fetNewData(notification: Notification){
        //        print("sadasdadasdasdasdadasdsad")
        //        print(searchVc?.passdatatest )
        print((notification.userInfo?["location"])! as! String)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //        let value = DataManager.shared.getCurrentMeasureType()
        //print(currentLocation)
        collectionView.reloadData()
    }
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        collectionView.register(UINib(nibName: "ConditionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ConditionCollectionViewCell")
        collectionView.register(UINib(nibName: "AirConditonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AirConditonCollectionViewCell")
        
    }
    
    func takeCurrentLocation(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

extension ToDayViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location")
        if let location = locations.last {
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            print("lat: \(lat)")
            print("lon: \(lon)")
            APICaller.shared.getLocationByGeoposition(lat: lat, lon: lon) { (result) in
                //                                APICaller.shared.getDayNightDataMetric(locationkey: result) { (daynight) in
                //                                    self.daynightData = daynight
                //                                    DataManager.shared.daynightData = daynight
                //                                    self.collectionView.reloadData()
                //                                }
                
                APICaller.shared.getDetailCurrentConditionWeather(locationId: result) { (currentResult) in
                    self.currentLocation = currentResult
                    DataManager.shared.currentLocationData = currentResult
                    self.collectionView.reloadData()
                }
                APICaller.shared.getnex12htWeatherMetric(locationId: result) { (next12result) in
                    self.next12hoursData = next12result
                    DataManager.shared.next12hData = next12result
//                    print(self.next12hoursData)
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)   
    }
}
extension ToDayViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
            if currentLocation.count > 0, next12hoursData.count > 0 {
                let currentdata = currentLocation[0]
                
                let next1 = next12hoursData[0]
                
                let next6 = next12hoursData[5]
                let next12 = next12hoursData[11]
                let value = DataManager.shared.getCurrentMeasureType()
                var type = ""
                //bind data
                
                let dateString = currentdata.LocalObservationDateTime ?? ""
                let dateFormatt = DateFormatter()
                dateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date = dateFormatt.date(from: dateString)
                
                let stringformat = DateFormatter()
                stringformat.dateFormat = "dd.MM.yy"
                let daytime = stringformat.string(from: date!)
                
                let image = String(currentdata.WeatherIcon ?? 1)
                let next1image = String(next1.WeatherIcon ?? 1)
                let next6image = String(next6.WeatherIcon ?? 1)
                let next12image = String(next12.WeatherIcon ?? 1)
                
                var temper = ""
                var next1temper = ""
                var next6temper = ""
                var next12temper = ""
                
                var feel = ""
                var next1feel = ""
                var next6feel = ""
                var next12feel = ""
                print(value)
                if value == MeasureType.metric.rawValue {
                    type = "C"
                    temper = String(currentdata.Temperature?.Metric?.Value ?? 0)
                    //
                    //
                    next1temper = String(next1.Temperature?.Value ?? 0)
                    next6temper = String(next1.Temperature?.Value ?? 0)
                    next12temper = String(next1.Temperature?.Value ?? 0)
                    
                    feel = "Real Feel: " + String(currentdata.RealFeelTemperature?.Metric?.Value ?? 0)
                    next1feel = String(next1.RealFeelTemperature?.Value ?? 0)
                    next6feel = String(next6.RealFeelTemperature?.Value ?? 0)
                    next12feel = String(next12.RealFeelTemperature?.Value ?? 0)
                    
                    
                } else if value == MeasureType.england.rawValue {
                    type = "F"
                    temper = String(currentdata.Temperature?.Imperial?.Value ?? 0)
                    next1temper = String(Double(next1.Temperature?.Value ?? 0)*1.8 + 32)
                    next6temper = String(Double(next6.Temperature?.Value ?? 0)*1.8 + 32)
                    next12temper = String(Double(next12.Temperature?.Value ?? 0)*1.8 + 32)
                    
                    feel = "Real Feel: " + String(currentdata.RealFeelTemperature?.Metric?.Value ?? 0)
                    next1feel = String(next1.RealFeelTemperature?.Value ?? 0)
                    next6feel = String(next6.RealFeelTemperature?.Value ?? 0)
                    next12feel = String(next12.RealFeelTemperature?.Value ?? 0)
                    
                } else {
                    type = "C"
                    temper = String(currentdata.Temperature?.Metric?.Value ?? 0)
                    //
                    //
                    next1temper = String(next1.Temperature?.Value ?? 0)
                    next6temper = String(next1.Temperature?.Value ?? 0)
                    next12temper = String(next1.Temperature?.Value ?? 0)
                    
                    feel = "Real Feel: " + String(currentdata.RealFeelTemperature?.Metric?.Value ?? 0)
                    next1feel = String(next1.RealFeelTemperature?.Value ?? 0)
                    next6feel = String(next6.RealFeelTemperature?.Value ?? 0)
                    next12feel = String(next12.RealFeelTemperature?.Value ?? 0)
                    
                    
                }
                
                cell.configWeatherCell(type: type, daytimelabel: daytime, image: image, tempe: temper, realfeel: feel, dayicon: next1image, daytem: next1temper, dayreal: next1feel, nighticon: next6image, nighttem: next6temper, nightReal: next6feel, nextdayicon: next12image, nextdautem: next12temper, nextdayfeel: next12feel)
                return cell
            }
            
            
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConditionCollectionViewCell", for: indexPath) as! ConditionCollectionViewCell
            cell.delegate = self
            if currentLocation.count > 0 {
                let data = currentLocation[0]
                let mesureType = DataManager.shared.getCurrentWindType()
                let windType = DataManager.shared.getCurrentWindType()
                var temper = ""
                var feel = ""
                var shade = ""
                var wind = ""
                var windgust = ""
                let hum = String(data.RelativeHumidity ?? 0)
                if mesureType == MeasureType.metric.rawValue {
                    temper = String(data.Temperature?.Metric?.Value ?? 0) + "ºC"
                    feel = String(data.RealFeelTemperature?.Metric?.Value ?? 0) + "ºC"
                    shade = String(data.RealFeelTemperatureShade?.Metric?.Value ?? 0) + "ºC"
                    wind = String(data.Wind?.Speed?.Metric?.Value ?? 0) + "km/h"
                    windgust = String(data.WindGust?.Speed?.Metric?.Value ?? 0) + "km/h"
                } else if mesureType == MeasureType.england.rawValue {
                    temper = String(data.Temperature?.Imperial?.Value ?? 0) +  "ºF"
                    feel = String(data.RealFeelTemperature?.Imperial?.Value ?? 0) + "ºF"
                    shade = String(data.RealFeelTemperatureShade?.Imperial?.Value ?? 0) + "ºF"
                    wind = String(data.Wind?.Speed?.Imperial?.Value ?? 0) + "dặm/h"
                    windgust = String(data.WindGust?.Speed?.Imperial?.Value ?? 0) + "dặm/h"
                } else {
                    temper = String(data.Temperature?.Metric?.Value ?? 0) + "ºC"
                    feel = String(data.RealFeelTemperature?.Metric?.Value ?? 0) + "ºC"
                    shade = String(data.RealFeelTemperatureShade?.Metric?.Value ?? 0) + "ºC"
                    wind = String(data.Wind?.Speed?.Imperial?.Value ?? 0) + "dặm/h"
                    wind = String(data.WindGust?.Speed?.Imperial?.Value ?? 0) + "dặm/h"
                }
                cell.configCell(temperature: temper, realFeel: feel, realFealShade: shade, wind: wind, windgust: windgust, humidity: hum)
                
            }
            
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirConditonCollectionViewCell", for: indexPath) as! AirConditonCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            let witdth = view.bounds.width
            let height = view.bounds.height
            return CGSize(width: witdth, height: height)
        }
        if indexPath.section == 1{
            let witdth = view.bounds.width
            return CGSize(width: witdth, height: witdth)
        }
        if indexPath.section == 1{
            let witdth = view.bounds.width
            return CGSize(width: witdth, height: 200)
        }
        return CGSize(width: 0, height: 0)
    }
    
}

extension ToDayViewController: ConditionCollectionViewCellDelegate{
    func tapViewMore() {
        navigationController?.pushViewController(MoreConditionDeatailViewController(), animated: true)
        ////        navigationController?.pushViewController(ByDayViewController(), animated: true)
        //        let vc = ByDayViewController()
        //        self.tabBarController?.selectedIndex = 2
    }
    
    
}

extension ToDayViewController: WeatherCollectionViewCellDelegate {
    func tapNext() {
    }
    
    
}

extension ToDayViewController: SettingViewControllerDelegate{
    func changeSetting() {
        collectionView.reloadData()
    }
    
    
}
extension ToDayViewController: SearchLocationViewControllerDelegate {
    func choseLocation(searchLocation: SearchLocation) {
        
    }
    
    func changeLocation(location: Location) {
        
    }
    
    func sendata(id: String) {
        print(id)
    }
    
    
}
