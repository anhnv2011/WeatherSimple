//
//  Next5day.swift
//  WeatherSimple
//
//  Created by MAC on 8/10/22.
//

import Foundation
import SwiftyJSON

struct Next5day {
    let DailyForecasts: [DailyForecasts3]?
    let Headline: Headline3?

    init(_ json: JSON) {
        Headline = Headline3(json["Headline"])
        DailyForecasts = json["DailyForecasts"].arrayValue.map { DailyForecasts3($0) }
    }

}
struct Headline3 {

    let EffectiveDate: String?
    let EffectiveEpochDate: Int?
    let Severity: Int?
    let Text: String?
    let Category: String?
    let EndDate: String?
    let EndEpochDate: Int?
    let MobileLink: String?
    let Link: String?

    init(_ json: JSON) {
        EffectiveDate = json["EffectiveDate"].stringValue
        EffectiveEpochDate = json["EffectiveEpochDate"].intValue
        Severity = json["Severity"].intValue
        Text = json["Text"].stringValue
        Category = json["Category"].stringValue
        EndDate = json["EndDate"].stringValue
        EndEpochDate = json["EndEpochDate"].intValue
        MobileLink = json["MobileLink"].stringValue
        Link = json["Link"].stringValue
    }

}
struct DailyForecasts3 {

    let Date: String?
    let EpochDate: Int?
    let Temperature: Temperature3?
    let Day: Day3?
    let Night: Night3?
    let Sources: [String]?
    let MobileLink: String?
    let Link: String?

    init(_ json: JSON) {
        Date = json["Date"].stringValue
        EpochDate = json["EpochDate"].intValue
        Temperature = Temperature3(json["Temperature"])
        Day = Day3(json["Day"])
        Night = Night3(json["Night"])
        Sources = json["Sources"].arrayValue.map { $0.stringValue }
        MobileLink = json["MobileLink"].stringValue
        Link = json["Link"].stringValue
    }

}

struct Temperature3 {

    let Minimum: Minimum3?
    let Maximum: Maximum3?

    init(_ json: JSON) {
        Minimum = Minimum3(json["Minimum"])
        Maximum = Maximum3(json["Maximum"])
    }

}
struct Minimum3 {

    let Value: Double?
    let Unit: String?
    let UnitType: Int?

    init(_ json: JSON) {
        Value = json["Value"].doubleValue
        Unit = json["Unit"].stringValue
        UnitType = json["UnitType"].intValue
    }

}
struct Maximum3 {

    let Value: Double?
    let Unit: String?
    let UnitType: Int?

    init(_ json: JSON) {
        Value = json["Value"].doubleValue
        Unit = json["Unit"].stringValue
        UnitType = json["UnitType"].intValue
    }

}
struct Day3 {

    let Icon: Int?
    let IconPhrase: String?
    let HasPrecipitation: Bool?
    let PrecipitationType: String?
    let PrecipitationIntensity: String?

    init(_ json: JSON) {
        Icon = json["Icon"].intValue
        IconPhrase = json["IconPhrase"].stringValue
        HasPrecipitation = json["HasPrecipitation"].boolValue
        PrecipitationType = json["PrecipitationType"].stringValue
        PrecipitationIntensity = json["PrecipitationIntensity"].stringValue
    }

}
struct Night3 {

    let Icon: Int?
    let IconPhrase: String?
    let HasPrecipitation: Bool?
    let PrecipitationType: String?
    let PrecipitationIntensity: String?

    init(_ json: JSON) {
        Icon = json["Icon"].intValue
        IconPhrase = json["IconPhrase"].stringValue
        HasPrecipitation = json["HasPrecipitation"].boolValue
        PrecipitationType = json["PrecipitationType"].stringValue
        PrecipitationIntensity = json["PrecipitationIntensity"].stringValue
    }

}
