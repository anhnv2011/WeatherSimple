//
//  DataManager.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import Foundation
struct DataManager {
    static let shared = DataManager()
    
    func cacheFileURL(fileName: String) -> URL {
        return (FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first?.appendingPathComponent(fileName))!

    }
    
    func saveToday(data: Data, fileName: String){
        try? data.write(to: cacheFileURL(fileName: fileName), options: .atomicWrite)
    }
    
}
