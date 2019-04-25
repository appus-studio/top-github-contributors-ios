//
//  Services.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import DataLayer

struct Services {
    struct ContributorService {
        static var gitHubService: ContributorServiceProtocol {
            return GitHubServiceAdapter()
        }
    }
    struct GeocodingService {
        static var appleGeocodingService: GeocodingServiceProtocol {
            return AppleGeocodingServiceAdapter()
        }
    }
}
