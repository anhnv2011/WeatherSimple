//
//  ToDayViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import SideMenu
import CoreLocation
class ToDayViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let locationManager = CLLocationManager()
    let circleView = CircleView()
    let currentLocationURl = DataManager.shared.cacheFileURL(fileName: "currentlocation.json")
    
    var currentLocation = [CurrentLocation]()
    var daynightData = [DayNight]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeCurrentLocation()
        configureCollectionView()

        print(view.bounds.width)
        print(view.bounds.height)
        
//        APICaller.shared.getDayNightDataMetric(locationkey: "353412") { (result) in
//            print(result)
//        }
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
            APICaller.shared.getLocationByGeoposition(lat: lat, lon: lon) { (result) in
                APICaller.shared.getDetailCurrentConditionWeather(locationId: result) { (currentResult) in
                    print(currentResult)
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
