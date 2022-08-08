//
//  DayNight.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct DayNight {

    let Headline: Headline1?
    let DailyForecasts: [DailyForecasts1]?

    init(_ json: JSON) {
        Headline = Headline1(json["Headline"])
        DailyForecasts = json["DailyForecasts"].arrayValue.map { DailyForecasts1($0) }
    }

}
