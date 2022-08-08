//
//  CurrentLocation.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct CurrentLocation {

	let LocalObservationDateTime: String?
	let EpochTime: Int?
	let WeatherText: String?
	let WeatherIcon: Int?
	let HasPrecipitation: Bool?
	let PrecipitationType: Any?
	let IsDayTime: Bool?
	let Temperature: Temperature1?
	let RealFeelTemperature: RealFeelTemperature1?
	let RealFeelTemperatureShade: RealFeelTemperatureShade1?
	let RelativeHumidity: Int?
	let IndoorRelativeHumidity: Int?
	let DewPoint: DewPoint1?
	let Wind: Wind1?
	let WindGust: WindGust1?
	let UVIndex: Int?
	let UVIndexText: String?
	let Visibility: Visibility1?
	let ObstructionsToVisibility: String?
	let CloudCover: Int?
	let Ceiling: Ceiling1?
	let Pressure: Pressure1?
	let PressureTendency: PressureTendency1?
	let Past24HourTemperatureDeparture: Past24HourTemperatureDeparture1?
	let ApparentTemperature: ApparentTemperature1?
	let WindChillTemperature: WindChillTemperature1?
	let WetBulbTemperature: WetBulbTemperature1?
	let Precip1hr: Precip1hr1?
	let PrecipitationSummary: PrecipitationSummary1?
	let TemperatureSummary: TemperatureSummary1?
	let MobileLink: String?
	let Link: String?

	init(_ json: JSON) {
		LocalObservationDateTime = json["LocalObservationDateTime"].stringValue
		EpochTime = json["EpochTime"].intValue
		WeatherText = json["WeatherText"].stringValue
		WeatherIcon = json["WeatherIcon"].intValue
		HasPrecipitation = json["HasPrecipitation"].boolValue
		PrecipitationType = json["PrecipitationType"]
		IsDayTime = json["IsDayTime"].boolValue
		Temperature = Temperature1(json["Temperature"])
		RealFeelTemperature = RealFeelTemperature1(json["RealFeelTemperature"])
		RealFeelTemperatureShade = RealFeelTemperatureShade1(json["RealFeelTemperatureShade"])
		RelativeHumidity = json["RelativeHumidity"].intValue
		IndoorRelativeHumidity = json["IndoorRelativeHumidity"].intValue
		DewPoint = DewPoint1(json["DewPoint"])
		Wind = Wind1(json["Wind"])
		WindGust = WindGust1(json["WindGust"])
		UVIndex = json["UVIndex"].intValue
		UVIndexText = json["UVIndexText"].stringValue
		Visibility = Visibility1(json["Visibility"])
		ObstructionsToVisibility = json["ObstructionsToVisibility"].stringValue
		CloudCover = json["CloudCover"].intValue
		Ceiling = Ceiling1(json["Ceiling"])
		Pressure = Pressure1(json["Pressure"])
		PressureTendency = PressureTendency1(json["PressureTendency"])
		Past24HourTemperatureDeparture = Past24HourTemperatureDeparture1(json["Past24HourTemperatureDeparture"])
		ApparentTemperature = ApparentTemperature1(json["ApparentTemperature"])
		WindChillTemperature = WindChillTemperature1(json["WindChillTemperature"])
		WetBulbTemperature = WetBulbTemperature1(json["WetBulbTemperature"])
		Precip1hr = Precip1hr1(json["Precip1hr"])
		PrecipitationSummary = PrecipitationSummary1(json["PrecipitationSummary"])
		TemperatureSummary = TemperatureSummary1(json["TemperatureSummary"])
		MobileLink = json["MobileLink"].stringValue
		Link = json["Link"].stringValue
	}

}
