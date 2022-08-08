//
//  WindGust.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 07, 2022
//
import Foundation
import SwiftyJSON

struct WindGust1 {

	let Speed: Speed1?

	init(_ json: JSON) {
		Speed = Speed1(json["Speed"])
	}

}
