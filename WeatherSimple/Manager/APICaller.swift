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
    
}
struct APICaller {
    static let shared = APICaller()
    
    func autocompleteSearch(searchString: String, completion: @escaping (([SearchLocation]) -> Void)){
        guard let url = URL(string: "\(Constants.baseURL)locations/v1/cities/autocomplete?apikey=\(Constants.API_KEY)&q=\(searchString)") else {
            print(APIError.errorURL)
            return
        }
        print("\(url)")
        Alamofire.request(url).responseJSON { (response) in
            guard let value = response.result.value else {
                print(APIError.error("Something wrong"))
                return
            }
            
            let dataJson = JSON(value).arrayValue
            let dataResult = dataJson.map({SearchLocation($0)})
            completion(dataResult)
        }
        
    }
    
}


