//
//  CardViewForHourViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/10/22.
//

import UIKit

class CardViewForHourViewController: UIViewController {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var handlerView: UIView!
 
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humLabale: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    
    var arrData = [Next12]()
    override func viewDidLoad() {
        super.viewDidLoad()

        arrData = DataManager.shared.next12hData
        let data = arrData[0]
        let dateString = data.DateTime
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatt.date(from: dateString!)
        let stringformat = DateFormatter()
        stringformat.dateFormat = "HH:mm dd/MM"
        let time = stringformat.string(from: date!)
        
        dateLabel.text = time
        
        let icon = data.WeatherIcon
        iconImage.image = UIImage(named: String(icon!))
        
        let tem = data.Temperature?.Value
        temperatureLabel.text = String(tem!)
        
        let hum = data.RelativeHumidity
        humLabale.text = String(hum!)
        
        let uv = data.UVIndex
        uvLabel.text = String(uv!)
    
        let rain = data.RainProbability
        rainLabel.text = String(rain!) + "%"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
