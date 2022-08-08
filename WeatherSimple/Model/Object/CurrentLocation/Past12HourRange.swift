//
//  Past12HourRange.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct Past12HourRange1 {

	let Minimum: Minimum1?
	let Maximum: Maximum1?

	init(_ json: JSON) {
		Minimum = Minimum1(json["Minimum"])
		Maximum = Maximum1(json["Maximum"])
	}

}
