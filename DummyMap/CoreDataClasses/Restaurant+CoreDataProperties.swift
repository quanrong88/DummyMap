//
//  Restaurant+CoreDataProperties.swift
//  DummyMap
//
//  Created by TaMinhQuan on 04/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var bio: String?
    @NSManaged public var type: String?
    @NSManaged public var rate: Double
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
