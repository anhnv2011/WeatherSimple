//
//  PressureTendency.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct PressureTendency1 {

	let LocalizedText: String?
	let Code: String?

	init(_ json: JSON) {
		LocalizedText = json["LocalizedText"].stringValue
		Code = json["Code"].stringValue
	}

}
