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
    
    @IBOutlet weak var collectionView: UICollectionView!
    let locationManager = CLLocationManager()
    let circleView = CircleView()
    let currentLocationURl = DataManager.shared.cacheFileURL(fileName: "currentlocation.json")
    
    var currentLocation = [CurrentLocation]()
    var next12hoursData = [CurrentLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeCurrentLocation()
        configureCollectionView()
        
        print(view.bounds.width)
        print(view.bounds.height)
        
        //        APICaller.shared.getDayNightDataMetric(locationkey: "353412") { (result) in
        //            print(result)
        //        }
        getData()
    }
    
    func getData(){
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
                 let dataResult = dataJson.map({CurrentLocation($0)})
                self.next12hoursData = dataResult
                print(self.next12hoursData)
             })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
//            APICaller.shared.getLocationByGeoposition(lat: lat, lon: lon) { (result) in
//                //                APICaller.shared.getDayNightDataMetric(locationkey: result) { (daynight) in
//                //                    self.daynightData = daynight
//                //                    DataManager.shared.daynightData = daynight
//                //                    self.collectionView.reloadData()
//                //                }
//
//                APICaller.shared.getDetailCurrentConditionWeather(locationId: result) { (currentResult) in
//                    self.currentLocation = currentResult
//                    DataManager.shared.currentLocationData = currentResult
//                    self.collectionView.reloadData()
//                }
//                APICaller.shared.getnex12htWeatherMetric(locationId: result) { (next12result) in
//                    self.next12hoursData = next12result
//                    DataManager.shared.currentLocationData = next12result
//                    print(self.next12hoursData)
//                    self.collectionView.reloadData()
//                }
                
//            }
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
                let daytime = currentdata.LocalObservationDateTime ?? ""
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
                
                if value == MeasureType.metric.rawValue {
                    type = "C"
                    temper = String(currentdata.Temperature?.Metric?.Value ?? 0)
                    next1temper =  String((next1.Temperature?.Metric?.Value!)!)
                    next6temper =  String(next6.Temperature?.Metric?.Value ?? 0)
                    next12temper =  String(next12.Temperature?.Metric?.Value ?? 0)
                    
                    feel = String(currentdata.RealFeelTemperature?.Metric?.Value ?? 0)
                    next1feel = String(next1.RealFeelTemperature?.Metric?.Value ?? 0)
                    next6feel = String(next6.RealFeelTemperature?.Metric?.Value ?? 0)
                    next12feel = String(next12.RealFeelTemperature?.Metric?.Value ?? 0)
                    
                    
                } else if value == MeasureType.england.rawValue {
                    
                } else {
                    
                    
                }
                
                cell.configWeatherCell(type: type, daytimelabel: daytime, image: image, tempe: temper, realfeel: feel, dayicon: next1image, daytem: next1temper, dayreal: next1feel, nighticon: next6image, nighttem: next6temper, nightReal: next6feel, nextdayicon: next12image, nextdautem: next12temper, nextdayfeel: next12feel)
                return cell
            }
            
            
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConditionCollectionViewCell", for: indexPath) as! ConditionCollectionViewCell
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
    }
    
    
}

extension ToDayViewController: WeatherCollectionViewCellDelegate {
    func tapNext() {
        print("tap next")
    }
    
    
}
