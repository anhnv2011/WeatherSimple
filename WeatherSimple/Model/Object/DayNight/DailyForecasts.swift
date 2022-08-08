//
//  DailyForecasts.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct DailyForecasts1 {

    let Date: String?
    let EpochDate: Int?
    let Sun: Sun1?
    let Moon: Moon1?
    let Temperature: Temperature1?
    let RealFeelTemperature: RealFeelTemperature1?
    let RealFeelTemperatureShade: RealFeelTemperatureShade1?
    let HoursOfSun: Double?
    let DegreeDaySummary: DegreeDaySummary1?
    let AirAndPollen: [AirAndPollen1]?
    let Day: Day1?
    let Night: Night1?
    let Sources: [String]?
    let MobileLink: String?
    let Link: String?

    init(_ json: JSON) {
        Date = json["Date"].stringValue
        EpochDate = json["EpochDate"].intValue
        Sun = Sun1(json["Sun"])
        Moon = Moon1(json["Moon"])
        Temperature = Temperature1(json["Temperature"])
        RealFeelTemperature = RealFeelTemperature1(json["RealFeelTemperature"])
        RealFeelTemperatureShade = RealFeelTemperatureShade1(json["RealFeelTemperatureShade"])
        HoursOfSun = json["HoursOfSun"].doubleValue
        DegreeDaySummary = DegreeDaySummary1(json["DegreeDaySummary"])
        AirAndPollen = json["AirAndPollen"].arrayValue.map { AirAndPollen1($0) }
        Day = Day1(json["Day"])
        Night = Night1(json["Night"])
        Sources = json["Sources"].arrayValue.map { $0.stringValue }
        MobileLink = json["MobileLink"].stringValue
        Link = json["Link"].stringValue
    }

}
