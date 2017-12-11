//
//  MapAnnotation.swift
//  DummyMap
//
//  Created by TaMinhQuan on 06/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class MapAnnotation: NSObject, MKAnnotation, GetableIconImage, GetableTintColor {
    var title: String?
    var subtitle: String?
    var type: RestaurantType
    var coordinate: CLLocationCoordinate2D
    
    init(restaurant: RestaurantDataModel) {
        title = restaurant.name
        subtitle = restaurant.bio
        type = restaurant.type
        coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
        super.init()
    }
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
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
