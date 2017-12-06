//
//  MapMakerView.swift
//  DummyMap
//
//  Created by TaMinhQuan on 06/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import MapKit

class MapMakerView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            guard let mapAnnotation = newValue as? MapAnnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            markerTintColor = mapAnnotation.makerTintColor
            glyphImage = mapAnnotation.image
        }
    }

}
