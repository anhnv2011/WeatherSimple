//
//  HourTableViewCell.swift
//  WeatherSimple
//
//  Created by MAC on 8/10/22.
//

import UIKit

class HourTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feelLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var temLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(time: String, feel: String, icon: String, tem: String){
        timeLabel.text = time
        feelLabel.text = feel
        iconImage.image = UIImage(named: "\(icon)")
        temLabel.text = tem
        
    }
    
}
