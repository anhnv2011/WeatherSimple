//
//  Location+CoreDataProperties.swift
//  
//
//  Created by MAC on 8/6/22.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var key: String?
    @NSManaged public var localizedName: String?
    @NSManaged public var countryID: String?
    @NSManaged public var countryLocalizedName: String?
    @NSManaged public var adminLocalizedName: String?
    @NSManaged public var adminID: String?

}
extension Location : Identifiable {

}
