//
//  WindGust.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2022
//
import Foundation
import SwiftyJSON

struct WindGust2 {

	let Speed: Speed2?

	init(_ json: JSON) {
		Speed = Speed2(json["Speed"])
	}

}
