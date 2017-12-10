//
//  DataManager.swift
//  DummyMap
//
//  Created by Ta Minh Quan on 10/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    var dataSource: [RestaurantDataModel] = []
    static let shareInstance = DataManager()
    let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
    func loadData(completion: @escaping ([RestaurantDataModel]) -> Void) {
        if !previouslyLaunched {
            ApiClient.getRestaurantList(completion: completion)
        } else {
            PersistenceManager.fetchRestaurantModelList(completion: completion)
        }
    }
    func reloadData(completion: @escaping ([RestaurantDataModel]) -> Void) {
        PersistenceManager.clearAllData()
        ApiClient.getRestaurantList(completion: completion)
    }
}
