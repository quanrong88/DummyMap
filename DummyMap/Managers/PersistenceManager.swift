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
    
    lazy var coreDataStack = CoreDataStack(modelName: "DummyMap")
    
    static let sharedInstance = PersistenceManager()
    
    func parseJsonData(input: [[String:Any]], completion: @escaping ([Restaurant]) -> Void) {
        coreDataStack.storeContainer.performBackgroundTask { [unowned self] (context) in
            for dict in input {
                self.insertNewShopEntity(dict: dict, context: context)
            }
            try! context.save()
            DispatchQueue.main.async {
                self.coreDataStack.saveContext()
                self.fetchRestaurantList(completion: completion)
            }
            
        }
        
        
    }
    func insertNewShopEntity(dict: [String:Any], context: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Restaurant",
                                                      in: context) else { return }
        let restaurant = Restaurant(entity: entity, insertInto: coreDataStack.managedContext)
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
            let results = try coreDataStack.managedContext.fetch(request)
            completion(results)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
