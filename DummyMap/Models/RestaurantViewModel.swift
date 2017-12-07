//
//  RestaurantViewModel.swift
//  DummyMap
//
//  Created by TaMinhQuan on 07/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import Foundation

enum RestaurantType: String {
    case hawk = "hawk"
    case coffee = "coffee"
    case fastfood = "fastfood"
    case streettea = "streettea"
    case na = "N/a"
}

struct RestaurantViewModel {
    var name: String
    var bio: String
    var type: RestaurantType
    var rate: Double
    
    init(restaurant: Restaurant) {
        name = restaurant.name ?? ""
        bio = restaurant.bio ?? ""
        if let restaurantType = restaurant.type {
            type = RestaurantType(rawValue: restaurantType) ?? .na
        } else { type = .na }
        rate = restaurant.rate
    }
    
    init(dict: [String:Any]) {
        name = dict["name"] as? String ?? ""
        bio = dict["bio"] as? String ?? ""
        if let restaurantType = dict["type"] as? String {
            type = RestaurantType(rawValue: restaurantType) ?? .na
        } else { type = .na }
        rate = dict["rate"] as? Double ?? 0
    }
    
}
