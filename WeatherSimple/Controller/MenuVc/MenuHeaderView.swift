//
//  MenuHeaderView.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
protocol MenuHeaderViewDelegate {
    func tapSettingButton()
}

class MenuHeaderView: UITableViewHeaderFooterView {

    
    static let identifier = "MenuHeader"
    
    
    
    private let settingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Cài đặt"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let settingButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "button"

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    var delegate: MenuHeaderViewDelegate?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
     
        settingButton.addTarget(self, action: #selector(tapSettingButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    @objc func tapSettingButton(){
        
        delegate?.tapSettingButton()
    }

    func setupLayout(){
        addSubview(settingImageView)
        settingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        settingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        settingImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        settingImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(settingLabel)
        settingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        settingLabel.leadingAnchor.constraint(equalTo: settingImageView.trailingAnchor, constant: 16).isActive = true
        settingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(settingButton)
        settingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        settingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
