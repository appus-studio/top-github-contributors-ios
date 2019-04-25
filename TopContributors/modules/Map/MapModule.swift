//
//  MapModule.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

final class MapModule: Module<MapViewController, MapPresenter, MapInteractor, MapRouter> {
    init(location: Location, name: String) {
        super.init()
        // injection
        interactor.location = location
        interactor.name = name
    }
}
