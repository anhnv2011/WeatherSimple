//
//  Wind.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct Wind1 {

	let Direction: Direction1?
	let Speed: Speed1?

	init(_ json: JSON) {
		Direction = Direction1(json["Direction"])
		Speed = Speed1(json["Speed"])
	}

}
