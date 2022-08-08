//
//  Sun.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct Sun1 {

    let Rise: String?
    let EpochRise: Int?
    let Set: String?
    let EpochSet: Int?

    init(_ json: JSON) {
        Rise = json["Rise"].stringValue
        EpochRise = json["EpochRise"].intValue
        Set = json["Set"].stringValue
        EpochSet = json["EpochSet"].intValue
    }

}
