//
//  ContributorsListInteractor.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

final class ContributorsListInteractor: ViperInteractor {
    weak var presenter: ContributorsListPresenterProtocol!
    var contributorService: ContributorServiceProtocol!
    var geocodingService: GeocodingServiceProtocol!
    var contributers = [ContributorListUserEntity]()
}

public enum ContributorsGeocodingError: Error {
    case noLocation
}

extension ContributorsListInteractor: ContributorsListInteractorProtocol {
    func fetchContributorLocation(contributor: ContributorListUserEntity, completion: ((Result<Location, Error>) -> Void)?) {
        let login = contributor.login
        contributorService.getUser(name: login) { (result) in
            switch result {
            case .failure(let error):
                completion?(Result.failure(error))
            case .success(let user):
                guard let location = user.location else {
                    completion?(Result.failure(ContributorsGeocodingError.noLocation))
                    return
                }
                self.geocodingService.geoCodeAddress(location, completion: { (result) in
                    completion?(result)
                })
            }
        }
    }
    func fetchContributors(first: Int, completion: ((Result<[ContributorListUserEntity], Error>) -> Void)?) {
        contributorService.getContributors(first: first) { (result) in
            switch result {
            case .success(let users):
                self.contributers = users
            case .failure:
                break
            }
            completion?(result)
        }
    }
}
