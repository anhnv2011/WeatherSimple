//
//  AirAndPollen.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct AirAndPollen1 {

    let Name: String?
    let Value: Int?
    let Category: String?
    let CategoryValue: Int?
    let TypeField: String?

    init(_ json: JSON) {
        Name = json["Name"].stringValue
        Value = json["Value"].intValue
        Category = json["Category"].stringValue
        CategoryValue = json["CategoryValue"].intValue
        TypeField = json["Type"].stringValue
    }

}
