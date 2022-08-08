//
//  DegreeDaySummary.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct DegreeDaySummary1 {

    let Heating: Heating1?
    let Cooling: Cooling1?

    init(_ json: JSON) {
        Heating = Heating1(json["Heating"])
        Cooling = Cooling1(json["Cooling"])
    }

}
