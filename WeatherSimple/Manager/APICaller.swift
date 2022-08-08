//
//  APICaller.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Constants {
    static let API_KEY = "90LKUI4g3wxlc1GAd1Vh1tqFVc1KZvvG"
    static let baseURL = "http://dataservice.accuweather.com/"
    //https://developer.accuweather.com/sites/default/files/07-s.png
    
}
struct APICaller {
    static let shared = APICaller()

    func autocompleteSearch(searchString: String, completion: @escaping (([SearchLocation]) -> Void)){
        guard let url = URL(string: "\(Constants.baseURL)locations/v1/cities/autocomplete?") else {
            print(APIError.errorURL)
            return
        }
        let param:Parameters = [
            "apikey" : "\(Constants.API_KEY)",
            "q" : "\(searchString)"
        ]

        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {(response) in
            guard let value = response.result.value else {
                print(APIError.error("Something wrong"))
                return
            }
            
            let dataJson = JSON(value).arrayValue
            let dataResult = dataJson.map({SearchLocation($0)})
            completion(dataResult)
        }

    }
    
    func getDetailCurrentConditionWeather(locationId: String, completion: @escaping (([CurrentLocation]) -> Void)){
        guard let url = URL(string: "\(Constants.baseURL)currentconditions/v1/\(locationId)?") else {
            print(APIError.errorURL)
            return
        }
//        print(url)
        let param:Parameters = [
            "apikey" : "\(Constants.API_KEY)",
            "details" : "true"
        ]
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {(response) in
            guard let value = response.result.value else {
                print(APIError.error("Something wrong"))
                return
            }
            
            let dataJson = JSON(value).arrayValue
            let dataResult = dataJson.map({CurrentLocation($0)})
            completion(dataResult)
        }
        
    }
    func getCurrentConditionWeather(locationId: String, completion: @escaping (([CurrentLocation]) -> Void)){
        guard let url = URL(string: "\(Constants.baseURL)currentconditions/v1/\(locationId)?") else {
            print(APIError.errorURL)
            return
        }
        print(url)
        let param:Parameters = [
            "apikey" : "\(Constants.API_KEY)",
        ]
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {(response) in
            guard let value = response.result.value else {
                print(APIError.error("Something wrong"))
                return
            }
            
            let dataJson = JSON(value).arrayValue
            let dataResult = dataJson.map({CurrentLocation($0)})
            completion(dataResult)
        }
        
    }
    func getLocationByGeoposition(lat: String, lon: String, completion: @escaping ((String)-> Void)){
        guard let url = URL(string: "\(Constants.baseURL)locations/v1/cities/geoposition/search?") else {
            print(APIError.errorURL)
            return
        }

        let param:Parameters = [
            "apikey" : "\(Constants.API_KEY)",
            "q" : "\(lat),\(lon)"
        ]
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {(response) in
            guard let value = response.result.value else {
                print(APIError.error("Something wrong"))
                return
            }
            
            let dataJson = JSON(value)
            let dataResult = LocationByGeoposition(dataJson).Key
            
            completion(dataResult!)
        }
    
    }
    
    func getDayNightDataMetric(locationkey: String, completion: @escaping ((DayNight) -> ())){
        guard let url = URL(string: "\(Constants.baseURL)forecasts/v1/daily/1day/\(locationkey)?") else {
            print(APIError.errorURL)
            return
        }
        let param:Parameters = [
            "apikey" : "\(Constants.API_KEY)",
            "details" : "true"
        ]
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON {(response) in
            guard let value = response.result.value else {
                print(APIError.error("Something wrong"))
                return
            }
            
            let dataJson = JSON(value)
            let dataResult = DayNight(dataJson)
            
            completion(dataResult)
        }
    }
}


