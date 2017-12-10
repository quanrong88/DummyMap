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
    
    static let coreDataStack = CoreDataStack(modelName: "DummyMap")
    
    class func parseJsonData(input: [[String:Any]]) {
        coreDataStack.storeContainer.performBackgroundTask { (context) in
            for dict in input {
                self.insertNewShopEntity(dict: dict, context: context)
            }
            try! context.save()
            self.coreDataStack.saveContext()
            DispatchQueue.main.async {
                self.fetchRestaurantList(completion: { (_) in })
            }
            
        }
    }
    class func insertNewShopEntity(dict: [String:Any], context: NSManagedObjectContext) {
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
    class func fetchRestaurantList(completion: @escaping ([Restaurant]) -> Void) {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do {
            let results = try coreDataStack.managedContext.fetch(request)
            completion(results)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    class func fetchRestaurantModelList(completion: @escaping ([RestaurantViewModel]) -> Void) {
        fetchRestaurantList(completion: { (restaurants ) in
            var result: [RestaurantViewModel] = []
            for item in restaurants {
                let model = RestaurantViewModel(restaurant: item)
                result.append(model)
            }
            completion(result)
        })
    }
    class func clearAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try coreDataStack.managedContext.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
    }
}
