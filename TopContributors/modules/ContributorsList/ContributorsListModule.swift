//
//  ContributorsList.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

final class ContributorsListModule: Module<ContributorsListViewController, ContributorsListPresenter, ContributorsListInteractor, ContributorsListRouter> {
    required init(contributorService: ContributorServiceProtocol, geocodingService: GeocodingServiceProtocol) {
        super.init()
        // injection
        interactor.contributorService = contributorService
        interactor.geocodingService = geocodingService
    }
}
