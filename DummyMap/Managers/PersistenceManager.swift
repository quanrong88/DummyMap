//
//  PersistenceManager.swift
//  DummyMap
//
//  Created by TaMinhQuan on 06/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import CoreData

class PersistenceManager: NSObject {
    
    var managedContext: NSManagedObjectContext!
    static let sharedInstance = PersistenceManager()
    override init() {
        super.init()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.coreDataStack.managedContext
    }
    
    func parseJsonData(input: [[String:Any]], completion: @escaping ([Restaurant]) -> Void) {
        for dict in input {
            insertNewShopEntity(dict: dict)
        }
        try! managedContext.save()
        fetchRestaurantList(completion: completion)
    }
    func insertNewShopEntity(dict: [String:Any]) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Restaurant",
                                                      in: managedContext) else { return }
        let restaurant = Restaurant(entity: entity, insertInto: managedContext)
        restaurant.id = dict["id"] as? String
        restaurant.name = dict["name"] as? String
        restaurant.bio = dict["bio"] as? String
        restaurant.type = dict["type"] as? String
        restaurant.rate = dict["rate"] as? Double ?? 0
        restaurant.latitude = dict["latitude"] as? Double ?? 0
        restaurant.longitude = dict["longitude"] as? Double ?? 0
    }
    func fetchRestaurantList(completion: @escaping ([Restaurant]) -> Void) {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do {
            let results = try managedContext.fetch(request)
            completion(results)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
