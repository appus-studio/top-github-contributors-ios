//
//  MapPresenter.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

final class MapPresenter: ViperPresenter {
    weak var view: MapViewProtocol!
    weak var interactor: MapInteractorProtocol!
    weak var router: MapRouterProtocol!
}

extension MapPresenter: MapPresenterProtocol {
    func viewDidLoad() {
        guard let location = self.interactor.location else {
            fatalError()
        }
        let latitude = location.lat
        let longitude = location.long
        let title = self.interactor.name ?? ""
        self.view.addAnnotation(lat: latitude, long: longitude, title: title)
        self.view.canter(lat: latitude, long: longitude)
    }
}
