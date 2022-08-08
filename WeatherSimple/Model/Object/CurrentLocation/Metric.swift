//
//  Metric.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct Metric1 {

	let Value: Double?
	let Unit: String?
	let UnitType: Int?

	init(_ json: JSON) {
		Value = json["Value"].doubleValue
		Unit = json["Unit"].stringValue
		UnitType = json["UnitType"].intValue
	}

}
