//
//  Day.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct Day1 {

    let Icon: Int?
    let IconPhrase: String?
    let HasPrecipitation: Bool?
    let PrecipitationType: String?
    let PrecipitationIntensity: String?
    let ShortPhrase: String?
    let LongPhrase: String?
    let PrecipitationProbability: Int?
    let ThunderstormProbability: Int?
    let RainProbability: Int?
    let SnowProbability: Int?
    let IceProbability: Int?
    let Wind: Wind1?
    let WindGust: WindGust1?
    let TotalLiquid: TotalLiquid1?
    let Rain: Rain1?
    let Snow: Snow1?
    let Ice: Ice1?
    let HoursOfPrecipitation: Int?
    let HoursOfRain: Int?
    let HoursOfSnow: Int?
    let HoursOfIce: Int?
    let CloudCover: Int?
    let Evapotranspiration: Evapotranspiration1?
    let SolarIrradiance: SolarIrradiance1?

    init(_ json: JSON) {
        Icon = json["Icon"].intValue
        IconPhrase = json["IconPhrase"].stringValue
        HasPrecipitation = json["HasPrecipitation"].boolValue
        PrecipitationType = json["PrecipitationType"].stringValue
        PrecipitationIntensity = json["PrecipitationIntensity"].stringValue
        ShortPhrase = json["ShortPhrase"].stringValue
        LongPhrase = json["LongPhrase"].stringValue
        PrecipitationProbability = json["PrecipitationProbability"].intValue
        ThunderstormProbability = json["ThunderstormProbability"].intValue
        RainProbability = json["RainProbability"].intValue
        SnowProbability = json["SnowProbability"].intValue
        IceProbability = json["IceProbability"].intValue
        Wind = Wind1(json["Wind"])
        WindGust = WindGust1(json["WindGust"])
        TotalLiquid = TotalLiquid1(json["TotalLiquid"])
        Rain = Rain1(json["Rain"])
        Snow = Snow1(json["Snow"])
        Ice = Ice1(json["Ice"])
        HoursOfPrecipitation = json["HoursOfPrecipitation"].intValue
        HoursOfRain = json["HoursOfRain"].intValue
        HoursOfSnow = json["HoursOfSnow"].intValue
        HoursOfIce = json["HoursOfIce"].intValue
        CloudCover = json["CloudCover"].intValue
        Evapotranspiration = Evapotranspiration1(json["Evapotranspiration"])
        SolarIrradiance = SolarIrradiance1(json["SolarIrradiance"])
    }

}
