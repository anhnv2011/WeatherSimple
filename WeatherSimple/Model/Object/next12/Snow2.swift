//
//  Snow.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2022
//
import Foundation
import SwiftyJSON

struct Snow2 {

	let Value: Int?
	let Unit: String?
	let UnitType: Int?

	init(_ json: JSON) {
		Value = json["Value"].intValue
		Unit = json["Unit"].stringValue
		UnitType = json["UnitType"].intValue
	}

}
