//
//  File.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import Foundation
enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        }
    }
}
