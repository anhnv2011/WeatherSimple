//
//  SettingViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import UIKit
protocol SettingViewControllerDelegate: AnyObject  {
    func changeSetting()
}
class SettingViewController: UIViewController {

    @IBOutlet weak var containView: UIView!
    
    @IBOutlet weak var englandMesureButton: UIButton!
    @IBOutlet weak var metricMeasureButton: UIButton!
    @IBOutlet weak var compoudMeasureButton: UIButton!
    @IBOutlet weak var windMetricButton: UIButton!
    @IBOutlet weak var windRadiusButton: UIButton!
    @IBOutlet weak var lightShowButton: UIButton!
    @IBOutlet weak var darkShowButton: UIButton!
    @IBOutlet weak var customShowButton: UIButton!
    
    var delegate: SettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Setting"
        setupUI()
    }
    
    func setupUI(){
        englandMesureButton.layer.cornerRadius = 24
        englandMesureButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        compoudMeasureButton.layer.cornerRadius = 24
        compoudMeasureButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        windMetricButton.layer.cornerRadius = 24
        windMetricButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        windRadiusButton.layer.cornerRadius = 24
        windRadiusButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        lightShowButton.layer.cornerRadius = 24
        lightShowButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
       
        customShowButton.layer.cornerRadius = 24
        customShowButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        switch sender {
    
        case metricMeasureButton:
            tapmetricMeasureButton()
        case englandMesureButton:
            tapenglandMesureButton()
        case compoudMeasureButton:
            tapcompoudMeasureButton()
        case windMetricButton:
            tapwindDirectionButton()
        case windRadiusButton:
            tapwindRadiusButton()
        case lightShowButton:
            taplightShowButton()
        case darkShowButton:
            tapdarkShowButton()
        case customShowButton:
            tapcustomShowButton()
        default:
            print("")
        }
        
        
    }
    
    func tapmetricMeasureButton(){
        DataManager.shared.changeMeasureType(type: .metric)
        delegate?.changeSetting()
    }
    func tapenglandMesureButton(){
        DataManager.shared.changeMeasureType(type: .england)
        delegate?.changeSetting()
        
    }
    func tapcompoudMeasureButton(){
        DataManager.shared.changeMeasureType(type: .compound)
        delegate?.changeSetting()
    }
    func tapwindDirectionButton(){
        DataManager.shared.changeWindType(type: .direction)
    }
    func tapwindRadiusButton(){
        DataManager.shared.changeWindType(type: .radius)
    }
    func taplightShowButton(){
        DataManager.shared.changeShowType(type: .light)
    }
    func tapdarkShowButton(){
        DataManager.shared.changeShowType(type: .dark)
    }
    func tapcustomShowButton(){
        DataManager.shared.changeShowType(type: .custom)
        
    }
    
    
    
}
