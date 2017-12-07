//
//  MapVC.swift
//  DummyMap
//
//  Created by TaMinhQuan on 06/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: 21.033333, longitude: 105.849998)
    var annotationList: [MapAnnotation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        mapView.register(MapMakerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if annotationList.isEmpty {
            fetchAnnotation()
            mapView.addAnnotations(annotationList)
        }
        
    }
    // MARK: Ultilities function
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func fetchAnnotation() {
        PersistenceManager.sharedInstance.fetchRestaurantList(completion: { [unowned self] (restaurants) in
            for restaurant in restaurants {
                let annotation = MapAnnotation(restaurant: restaurant)
                self.annotationList.append(annotation)
            }
        })
    }

}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! MapAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
