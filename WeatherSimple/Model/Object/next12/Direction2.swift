//
//  Direction.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2022
//
import Foundation
import SwiftyJSON

struct Direction2 {

	let Degrees: Int?
	let Localized: String?
	let English: String?

	init(_ json: JSON) {
		Degrees = json["Degrees"].intValue
		Localized = json["Localized"].stringValue
		English = json["English"].stringValue
	}

}
