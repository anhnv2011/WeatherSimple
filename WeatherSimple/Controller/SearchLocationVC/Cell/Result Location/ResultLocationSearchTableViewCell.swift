//
//  ResultLocationSearchTableViewCell.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit

class ResultLocationSearchTableViewCell: UITableViewCell {

    static let identify = "ResultLocationSearchTableViewCell"
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(location: String){
        locationLabel.text = location
    }
    
}
