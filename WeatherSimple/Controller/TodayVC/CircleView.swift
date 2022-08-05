//
//  CircleView.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit

class CircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2 - self.frame.size.height/2,
        y: 0.0,
        width: self.frame.size.height,
        height: self.frame.size.height))

        UIColor.orange.setFill()
        path.fill()
    }
    
}
