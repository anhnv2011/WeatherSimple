//
//  CardViewViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit

class CardViewViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var hasPrecipitationLabel: UILabel!
    @IBOutlet weak var precipitationTypeLabel: UILabel!
    @IBOutlet weak var precipitationIntensityLabel: UILabel!
    
    var next5dayData:Next5day?
    @IBOutlet weak var handlerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.next5dayData = DataManager.shared.next5dData
        print(next5dayData)
    }


    @IBAction func changeDayState(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            changeToDay()
        } else if sender.selectedSegmentIndex == 1 {
            changeToNight()
        }
    }
    
    func changeToDay(){
        if next5dayData != nil {
            let data = next5dayData?.DailyForecasts
            
            let dateString = data?[0].Date ?? ""
            let dateFormatt = DateFormatter()
            dateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatt.date(from: dateString)
            let stringformat = DateFormatter()
            stringformat.dateFormat = "MM/dd/yyyy"
            let time = stringformat.string(from: date!)
            
            let icon = String((data![0].Day?.Icon)!)
            let type = data![0].Day?.IconPhrase
            let haspre = String((data![0].Day?.HasPrecipitation)!)
            let prece = data![0].Day?.PrecipitationType
            let preceint = data![0].Day?.PrecipitationIntensity
            
            dayLabel.text = time
            iconImage.image = UIImage(named: "\(icon)")
            self.type.text = type
            hasPrecipitationLabel.text = haspre
            precipitationTypeLabel.text = prece
            precipitationIntensityLabel.text = preceint
        }
    }
    func changeToNight(){
        if next5dayData != nil {
            let data = next5dayData?.DailyForecasts
            
            let dateString = data![0].Date
            let dateFormatt = DateFormatter()
            dateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatt.date(from: dateString!)
            let stringformat = DateFormatter()
            stringformat.dateFormat = "MM/dd/yyyy"
            let time = stringformat.string(from: date!)
            
            let icon = String((data![0].Night?.Icon)!)
            let type = data![0].Night?.IconPhrase
            let haspre = String((data![0].Day?.HasPrecipitation)!)
            let prece = data![0].Night?.PrecipitationType
            let preceint = data![0].Night?.PrecipitationIntensity
            
            dayLabel.text = time
            iconImage.image = UIImage(named: "\(icon)")
            self.type.text = type
            hasPrecipitationLabel.text = haspre
            precipitationTypeLabel.text = prece
            precipitationIntensityLabel.text = preceint
        }
    }

    func fetchData(){
        
    }
}
