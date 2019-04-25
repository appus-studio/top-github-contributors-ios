//
//  MapInteractor.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

final class MapInteractor: ViperInteractor {
    weak var presenter: MapPresenterProtocol!

    var name: String!
    var location: Location!
}

extension MapInteractor: MapInteractorProtocol {
}
