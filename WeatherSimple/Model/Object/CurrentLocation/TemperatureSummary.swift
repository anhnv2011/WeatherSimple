//
//  TemperatureSummary.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct TemperatureSummary1 {

	let Past6HourRange: Past6HourRange1?
	let Past12HourRange: Past12HourRange1?
	let Past24HourRange: Past24HourRange1?

	init(_ json: JSON) {
		Past6HourRange = Past6HourRange1(json["Past6HourRange"])
		Past12HourRange = Past12HourRange1(json["Past12HourRange"])
		Past24HourRange = Past24HourRange1(json["Past24HourRange"])
	}

}
