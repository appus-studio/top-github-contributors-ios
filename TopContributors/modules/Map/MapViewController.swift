//
//  MapViewController.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, ViperView {
    var viperComponents: VIPERComponents!
    weak var presenter: MapPresenterProtocol!

    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension MapViewController: MapViewProtocol {
    func canter(lat: Double, long: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.mapView.setCenter(coordinate, animated: true)
    }
    func addAnnotation(lat: Double, long: Double, title: String) {
        self.title = title
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
