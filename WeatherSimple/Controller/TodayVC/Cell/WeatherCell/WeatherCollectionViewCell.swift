//
//  WeatherCollectionViewCell.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit
protocol WeatherCollectionViewCellDelegate: AnyObject {
    func tapNext()
}
class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var RealFealLabel: UILabel!
    @IBOutlet weak var dayIcon: UIImageView!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var dayRealFeelLabel: UILabel!
    @IBOutlet weak var nightIcon: UIImageView!
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    @IBOutlet weak var nightRealFeelLabel: UILabel!
    
    @IBOutlet weak var nextDayIcon: UIImageView!
    @IBOutlet weak var nextDayTempe: UILabel!
    @IBOutlet weak var nextdayRealFeel: UILabel!
   
    var delegate:WeatherCollectionViewCellDelegate?
    let settingVc = SettingViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherView.layer.cornerRadius = weatherView.frame.size.width/2
        settingVc.delegate = self
        view1.layer.cornerRadius = 20
        view2.layer.cornerRadius = 20
        view3.layer.cornerRadius = 20

    }

    func configWeatherCell(type: String, daytimelabel: String, image: String, tempe: String, realfeel: String, dayicon: String, daytem: String, dayreal: String, nighticon: String, nighttem: String, nightReal: String, nextdayicon: String, nextdautem: String, nextdayfeel: String){
        
        typeLable.text = type
        dayTimeLabel.text = daytimelabel
        imageView.image = UIImage(named: image)
        temperatureLabel.text = tempe
        RealFealLabel.text = realfeel
        dayIcon.image = UIImage(named: dayicon)
        dayTemperatureLabel.text = daytem
        dayRealFeelLabel.text = dayreal
        nightIcon.image = UIImage(named: nighticon)
        nightTemperatureLabel.text = nighttem
        
        nextDayIcon.image = UIImage(named: nextdayicon)
        nextDayTempe.text = nextdautem
        nextdayRealFeel.text = nextdayfeel
    }
    @IBAction func actionNext(_ sender: Any) {
        delegate?.tapNext()
    }
}
extension WeatherCollectionViewCell: SettingViewControllerDelegate {
    func changeSetting() {
        print("cell")
    }
    
    
}
