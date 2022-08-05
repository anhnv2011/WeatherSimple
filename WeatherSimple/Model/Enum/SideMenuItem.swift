//
//  SideMenuItem.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import Foundation

enum SideMenuItem: String, CaseIterable {
    case dubao = "Chúng tôi dự báo như thế nào"
    case gioithieu = "Giới thiệu về App"
    case lienhe = "Liên hệ"
    case xephang = "Xếp hạng "
    case chiase = "Chia sẻ ứng dụng của chúng tôi"
    
    var link:URL{
        switch self {
        case .dubao:
            return URL(string: "https://www.accuweather.com/")!
        case .gioithieu:
            return URL(string: "https://corporate.accuweather.com/company/about-us/")!
        case .lienhe:
            return URL(string: "https://corporate.accuweather.com/company/contact/")!
        case .xephang:
            return URL(string: "https://apps.apple.com/us/app/accuweather-weather-alerts/id300048137")!
        case .chiase:
            return URL(string: "https://apps.apple.com/vn/app/accuweather-weather-alerts/id300048137?l=vi")!
        }
    }
}
