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

    let locationManager = CLLocationManager()
  
    @IBOutlet weak var circleToDayView: UIView!
    let circleView = CircleView()
    override func viewDidLoad() {
        super.viewDidLoad()
       
       takeCurrentLocation()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        circleToDayView.addSubview(circleView)
        circleView.frame = circleToDayView.bounds
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
