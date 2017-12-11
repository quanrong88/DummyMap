//
//  GetableIconImage.swift
//  DummyMap
//
//  Created by TaMinhQuan on 11/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import Foundation
import UIKit

protocol GetableIconImage {
    var type: RestaurantType { get }
}

extension GetableIconImage {
    var image: UIImage {
        switch type {
        case .hawk:
            return #imageLiteral(resourceName: "bakery")
        case .coffee:
            return #imageLiteral(resourceName: "coffee")
        case .fastfood:
            return #imageLiteral(resourceName: "fastfood")
        case .streettea:
            return #imageLiteral(resourceName: "water")
        default:
            return #imageLiteral(resourceName: "food-icon")
        }
    }
}
