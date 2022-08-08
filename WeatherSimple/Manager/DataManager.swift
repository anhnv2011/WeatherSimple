//
//  DataManager.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON
class DataManager {
    static let shared = DataManager()
    
    //MARK:- Api current save
    var currentLocationData = [CurrentLocation]()
    var daynightData:DayNight?
    var next12hData = [CurrentLocation]()
    
    //MARK:- User defaultValue
    //Key
    let Measuare_Type = ""
    let Wind_Type = ""
    let Show_Type = ""

    
    func changeMeasureType(type: MeasureType){
        UserDefaults.standard.setValue(type.rawValue, forKey: Measuare_Type)
        UserDefaults.standard.synchronize()
    }
    func getCurrentMeasureType() -> String {
        return UserDefaults.standard.string(forKey: Measuare_Type) ?? ""
    }
    
    func changeWindType(type: WindType){
        UserDefaults.standard.setValue(type.rawValue, forKey: Wind_Type)
        UserDefaults.standard.synchronize()
    }
    func getCurrentWindType() -> String {
        return UserDefaults.standard.string(forKey: Wind_Type) ?? ""
    }
    func changeShowType(type: ShowType){
        UserDefaults.standard.setValue(type.rawValue, forKey: Show_Type)
        UserDefaults.standard.synchronize()
    }
    func getCurrentShowType() -> String {
        return UserDefaults.standard.string(forKey: Show_Type) ?? ""
    }
    
    //MARK:- FileManager
    
    func cacheFileURL(fileName: String) -> URL {
        return (FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first?.appendingPathComponent(fileName))!

    }
    
    func saveToday(data: Data, fileName: String){
        
        try? data.write(to: cacheFileURL(fileName: fileName), options: .atomicWrite)
    }
    
    //MARK:-Core data

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func creatNewLocationCoreData(key: String, localizedName: String, countryID: String, countryLocalizedName: String, adminID: String,  adminLocalizedName: String){
        
        let newLocation = Location(context: context)
        newLocation.key = key
        newLocation.localizedName = localizedName
        newLocation.countryID = countryID
        newLocation.countryLocalizedName = countryLocalizedName
        newLocation.adminID = adminID
        newLocation.adminLocalizedName = adminLocalizedName
        do {
            try context.save()
            print( "codata")
        } catch let error {
            print(error.localizedDescription)
            
        }
    }
    
    func deleteLocationCoreData(locationDelete: Location){
        self.context.delete(locationDelete)
        do {
            try! self.context.save()
        }
    }
    
}
