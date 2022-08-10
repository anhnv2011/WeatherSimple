//
//  Next12.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2022
//
import Foundation
import SwiftyJSON
import Alamofire

struct Next12 {

	let DateTime: String?
	let EpochDateTime: Int?
	let WeatherIcon: Int?
	let IconPhrase: String?
	let HasPrecipitation: Bool?
	let IsDaylight: Bool?
	let Temperature: Temperature2?
	let RealFeelTemperature: RealFeelTemperature2?
	let RealFeelTemperatureShade: RealFeelTemperatureShade2?
	let WetBulbTemperature: WetBulbTemperature2?
	let DewPoint: DewPoint2?
	let Wind: Wind2?
	let WindGust: WindGust2?
	let RelativeHumidity: Int?
	let IndoorRelativeHumidity: Int?
	let Visibility: Visibility2?
	let Ceiling: Ceiling2?
	let UVIndex: Int?
	let UVIndexText: String?
	let PrecipitationProbability: Int?
	let ThunderstormProbability: Int?
	let RainProbability: Int?
	let SnowProbability: Int?
	let IceProbability: Int?
	let TotalLiquid: TotalLiquid2?
	let Rain: Rain2?
	let Snow: Snow2?
	let Ice: Ice2?
	let CloudCover: Int?
	let Evapotranspiration: Evapotranspiration2?
	let SolarIrradiance: SolarIrradiance2?
	let MobileLink: String?
	let Link: String?

	init(_ json: JSON) {
		DateTime = json["DateTime"].stringValue
		EpochDateTime = json["EpochDateTime"].intValue
		WeatherIcon = json["WeatherIcon"].intValue
		IconPhrase = json["IconPhrase"].stringValue
		HasPrecipitation = json["HasPrecipitation"].boolValue
		IsDaylight = json["IsDaylight"].boolValue
		Temperature = Temperature2(json["Temperature"])
		RealFeelTemperature = RealFeelTemperature2(json["RealFeelTemperature"])
		RealFeelTemperatureShade = RealFeelTemperatureShade2(json["RealFeelTemperatureShade"])
		WetBulbTemperature = WetBulbTemperature2(json["WetBulbTemperature"])
		DewPoint = DewPoint2(json["DewPoint"])
		Wind = Wind2(json["Wind"])
		WindGust = WindGust2(json["WindGust"])
		RelativeHumidity = json["RelativeHumidity"].intValue
		IndoorRelativeHumidity = json["IndoorRelativeHumidity"].intValue
		Visibility = Visibility2(json["Visibility"])
		Ceiling = Ceiling2(json["Ceiling"])
		UVIndex = json["UVIndex"].intValue
		UVIndexText = json["UVIndexText"].stringValue
		PrecipitationProbability = json["PrecipitationProbability"].intValue
		ThunderstormProbability = json["ThunderstormProbability"].intValue
		RainProbability = json["RainProbability"].intValue
		SnowProbability = json["SnowProbability"].intValue
		IceProbability = json["IceProbability"].intValue
		TotalLiquid = TotalLiquid2(json["TotalLiquid"])
		Rain = Rain2(json["Rain"])
		Snow = Snow2(json["Snow"])
		Ice = Ice2(json["Ice"])
		CloudCover = json["CloudCover"].intValue
		Evapotranspiration = Evapotranspiration2(json["Evapotranspiration"])
		SolarIrradiance = SolarIrradiance2(json["SolarIrradiance"])
		MobileLink = json["MobileLink"].stringValue
		Link = json["Link"].stringValue
	}

}
