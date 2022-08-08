//
//  LocationByGeoposition.swift
//  WeatherSimple
//
//  Created by MAC on 8/7/22.
//

import Foundation
import SwiftyJSON
struct LocationByGeoposition {
    let Key: String?
    init(_ json: JSON) {
        Key = json["Key"].stringValue
    }
    
}
