//
//  MapProtocols.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol MapPresenterProtocol: class {
    func viewDidLoad()
}

protocol MapViewProtocol: class, ActivityIndication {
    func addAnnotation(lat: Double, long: Double, title: String)
    func canter(lat: Double, long: Double)
}

protocol MapInteractorProtocol: class {
    var location: Location! {get}
    var name: String! {get}
}

protocol MapRouterProtocol: class {
}
