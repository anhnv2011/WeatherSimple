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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeCurrentLocation()
        configureCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        collectionView.register(UINib(nibName: "DetailWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailWeatherCollectionViewCell")
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
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("lat: \(lat)")
            print("lon: \(lon)")
            
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
            return 2
        case 2:
            return 6
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
            return cell
        } else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailWeatherCollectionViewCell", for: indexPath) as! DetailWeatherCollectionViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConditionCollectionViewCell", for: indexPath) as! ConditionCollectionViewCell
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirConditonCollectionViewCell", for: indexPath) as! AirConditonCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
