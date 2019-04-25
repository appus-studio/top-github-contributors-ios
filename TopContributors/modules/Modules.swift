//
//  Modules.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

struct Modules {
    // MARK: ContributorsList
    static func contributorsList() -> ContributorsListModule {
        let contributorService = Services.ContributorService.gitHubService
        let geocodingService = Services.GeocodingService.appleGeocodingService
        return ContributorsListModule(contributorService: contributorService, geocodingService: geocodingService)
    }
    // MARK: Map
    static func map(location: Location, name: String) -> MapModule {
        return MapModule(location: location, name: name)
    }
}
