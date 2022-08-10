//
//  ConditionCollectionViewCell.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit

protocol ConditionCollectionViewCellDelegate: AnyObject  {
    func tapViewMore()
}
class ConditionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var containViewCell: UIView!
    @IBOutlet weak var realFeelLabel: UILabel!
    @IBOutlet weak var realFeelShade: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windGustlabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var delegate: ConditionCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionButton(_ sender: UIButton) {
        print("More")
        delegate?.tapViewMore()
    }
    func configCell(temperature: String, realFeel: String, realFealShade: String, wind: String, windgust: String, humidity: String){
        temperatureLabel.text = temperature
        realFeelLabel.text = realFeel
        realFeelShade.text = realFealShade
        windLabel.text = wind
        windGustlabel.text = windgust
        humidityLabel.text = humidity
    }
}
