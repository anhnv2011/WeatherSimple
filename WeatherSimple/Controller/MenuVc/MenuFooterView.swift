//
//  MenuFooterView.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit

class MenuFooterView: UITableViewHeaderFooterView {
    static let identifier = "MenuFooter"
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

    func setupLayout(){
       
    }
}
