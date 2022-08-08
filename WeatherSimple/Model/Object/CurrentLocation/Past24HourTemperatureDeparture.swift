//
//  Past24HourTemperatureDeparture.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct Past24HourTemperatureDeparture1 {

	let Metric: Metric1?
	let Imperial: Imperial1?

	init(_ json: JSON) {
		Metric = Metric1(json["Metric"])
		Imperial = Imperial1(json["Imperial"])
	}

}
