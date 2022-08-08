//
//  Rain.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON


struct Rain1 {

    let Value: Double?
    let Unit: String?
    let UnitType: Int?

    init(_ json: JSON) {
        Value = json["Value"].doubleValue
        Unit = json["Unit"].stringValue
        UnitType = json["UnitType"].intValue
    }

}
