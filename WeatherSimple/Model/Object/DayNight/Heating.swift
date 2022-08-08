//
//  Heating.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct Heating1 {

    let Value: Int?
    let Unit: String?
    let UnitType: Int?

    init(_ json: JSON) {
        Value = json["Value"].intValue
        Unit = json["Unit"].stringValue
        UnitType = json["UnitType"].intValue
    }

}
