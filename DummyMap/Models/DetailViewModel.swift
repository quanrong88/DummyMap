//
//  DetailViewModel.swift
//  DummyMap
//
//  Created by Ta Minh Quan on 10/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import Foundation
import UIKit

struct DetailViewModel {
    var name: String
    var bio: String
    var type: RestaurantType
    var rate: Double
    var backGround: UIImage {
        switch type {
        case .hawk:
            return #imageLiteral(resourceName: "hawk-bg")
        case .coffee:
            return #imageLiteral(resourceName: "coffee-bg")
        case .fastfood:
            return #imageLiteral(resourceName: "fastfood-bg")
        case .streettea:
            return #imageLiteral(resourceName: "streettea-bg")
        default:
            return #imageLiteral(resourceName: "streettea-bg")
        }
    }
    
    
    init(dataModel: RestaurantDataModel) {
        name = dataModel.name
        bio = dataModel.bio
        type = dataModel.type
        rate = dataModel.rate
    }
}
