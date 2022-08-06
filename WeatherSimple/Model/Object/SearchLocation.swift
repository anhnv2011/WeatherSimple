//
//  SearchLocation.swift
//  WeatherSimple
//
//  Created by MAC on 8/6/22.
//

import Foundation
import SwiftyJSON

struct SearchLocation {

    let Version: Int?
    let Key: String?
    let TypeField: String?
    let Rank: Int?
    let LocalizedName: String?
    let Country: Country1?
    let AdministrativeArea: AdministrativeArea1?

    init(_ json: JSON) {
        Version = json["Version"].intValue
        Key = json["Key"].stringValue
        TypeField = json["Type"].stringValue
        Rank = json["Rank"].intValue
        LocalizedName = json["LocalizedName"].stringValue
        Country = Country1(json["Country"])
        AdministrativeArea = AdministrativeArea1(json["AdministrativeArea"])
    }

}
