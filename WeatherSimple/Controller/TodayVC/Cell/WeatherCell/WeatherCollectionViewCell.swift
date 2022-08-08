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
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherView.layer.cornerRadius = weatherView.frame.size.width/2
    }

    func configWeatherCell(daytimelabel: String, image: String, tempe: String, realfeel: String, dayicon: String, daytem: String, dayreal: String, nighticon: String, nighttem: String, nightReal: String, nextdayicon: String, nextdautem: String, nextdayfeel: String){
        dayTimeLabel.text = daytimelabel
        imageView.image = UIImage(named: image)
        temperatureLabel.text = tempe
        RealFealLabel.text = realfeel
        dayIcon.image = UIImage(named: dayicon)
        dayTemperatureLabel.text = daytem
        dayRealFeelLabel.text = dayreal
        nightIcon.image = UIImage(named: nighticon)
        nightTemperatureLabel.text = nighttem
        
//        nextDayIcon.image = UIImage(named: nextdayicon)
//        nextDayTempe.text = nextdautem
//        nextdayRealFeel.text = nextdayfeel
    }
    @IBAction func actionNext(_ sender: Any) {
        delegate?.tapNext()
    }
}
