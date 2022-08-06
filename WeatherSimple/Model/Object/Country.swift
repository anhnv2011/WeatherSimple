//
//  Country.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import Foundation
import SwiftyJSON

struct Country1 {

    let ID: String?
    let LocalizedName: String?

    init(_ json: JSON) {
        ID = json["ID"].stringValue
        LocalizedName = json["LocalizedName"].stringValue
    }

}
