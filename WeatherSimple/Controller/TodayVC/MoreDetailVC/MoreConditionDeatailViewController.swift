//
//  MoreConditionDeatailViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import UIKit

class MoreConditionDeatailViewController: UIViewController {
    @IBOutlet weak var containViewCell: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var realFeelLabel: UILabel!
    @IBOutlet weak var realFeelShadeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windGustlabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityInHouseLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cloundCoverLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!

    
    
    var arrData = [CurrentLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

}
