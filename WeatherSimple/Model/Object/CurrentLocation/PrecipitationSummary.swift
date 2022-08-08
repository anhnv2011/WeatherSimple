//
//  PrecipitationSummary.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct PrecipitationSummary1 {

	let Precipitation: Precipitation1?
	let PastHour: PastHour1?
	let Past3Hours: Past3Hours1?
	let Past6Hours: Past6Hours1?
	let Past9Hours: Past9Hours1?
	let Past12Hours: Past12Hours1?
	let Past18Hours: Past18Hours1?
	let Past24Hours: Past24Hours1?

	init(_ json: JSON) {
		Precipitation = Precipitation1(json["Precipitation"])
		PastHour = PastHour1(json["PastHour"])
		Past3Hours = Past3Hours1(json["Past3Hours"])
		Past6Hours = Past6Hours1(json["Past6Hours"])
		Past9Hours = Past9Hours1(json["Past9Hours"])
		Past12Hours = Past12Hours1(json["Past12Hours"])
		Past18Hours = Past18Hours1(json["Past18Hours"])
		Past24Hours = Past24Hours1(json["Past24Hours"])
	}

}
