//
//  Direction.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct Direction1 {

	let Degrees: Int?
	let Localized: String?
	let English: String?

	init(_ json: JSON) {
		Degrees = json["Degrees"].intValue
		Localized = json["Localized"].stringValue
		English = json["English"].stringValue
	}

}
