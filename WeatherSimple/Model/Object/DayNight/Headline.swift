//
//  Headline.swift
//  WeatherSimple
//
//  Created by MAC on 8/8/22.
//

import Foundation
import SwiftyJSON

struct Headline1 {

    let EffectiveDate: String?
    let EffectiveEpochDate: Int?
    let Severity: Int?
    let Text: String?
    let Category: String?
    let EndDate: String?
    let EndEpochDate: Int?
    let MobileLink: String?
    let Link: String?

    init(_ json: JSON) {
        EffectiveDate = json["EffectiveDate"].stringValue
        EffectiveEpochDate = json["EffectiveEpochDate"].intValue
        Severity = json["Severity"].intValue
        Text = json["Text"].stringValue
        Category = json["Category"].stringValue
        EndDate = json["EndDate"].stringValue
        EndEpochDate = json["EndEpochDate"].intValue
        MobileLink = json["MobileLink"].stringValue
        Link = json["Link"].stringValue
    }

}
