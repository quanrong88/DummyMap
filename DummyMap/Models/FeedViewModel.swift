//
//  FeedViewModel.swift
//  DummyMap
//
//  Created by Ta Minh Quan on 10/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import Foundation
import UIKit

struct FeedViewModel: GetableIconImage, GetableTintColor {
    var name: String
    var type: RestaurantType
    var rate: Double
    
    init(dataModel: RestaurantDataModel) {
        name = dataModel.name
        type = dataModel.type
        rate = dataModel.rate
    }
}
