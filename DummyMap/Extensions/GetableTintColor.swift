//
//  GetableTintColor.swift
//  DummyMap
//
//  Created by TaMinhQuan on 11/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import Foundation
import UIKit

protocol GetableTintColor {
    var type: RestaurantType { get }
}

extension GetableTintColor {
    var makerTintColor: UIColor {
        switch type {
        case .hawk:
            return .orange
        case .coffee:
            return .brown
        case .fastfood:
            return .yellow
        case .streettea:
            return .green
        default:
            return .red
        }
    }
}
