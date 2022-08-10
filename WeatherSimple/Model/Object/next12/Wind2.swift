//
//  Wind.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2022
//
import Foundation
import SwiftyJSON

struct Wind2 {

	let Speed: Speed2?
	let Direction: Direction2?

	init(_ json: JSON) {
		Speed = Speed2(json["Speed"])
		Direction = Direction2(json["Direction"])
	}

}
