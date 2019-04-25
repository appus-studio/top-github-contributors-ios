//
//  AppleGeocodingServiceAdapter.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import DataLayer

class AppleGeocodingServiceAdapter: GeocodingServiceProtocol {
    var service = AppleGeocodingService()
    func geoCodeAddress(_ address: String, completion: ((Result<AppleGeocodingService.Coordinates, Error>) -> Void)?) {
        service.geoCodeAddress(address) { (result) in
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let location):
                completion?(.success(location))
            }
        }
    }
}
