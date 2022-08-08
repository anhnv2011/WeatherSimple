//
//  FavoriteTableViewCell.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var typeTemperLabel: UILabel!
    
    static let identifier = "FavoriteTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configFavoriteTableViewCell(location: String, country: String, image: String, temperature: String, type: String){
        locationLabel.text = location
        countryLabel.text = country
        temperatureLabel.text = temperature
        typeTemperLabel.text = type
        conditionImage.image = UIImage(named: image)
    }
}
