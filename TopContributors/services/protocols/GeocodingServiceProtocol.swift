//
//  GeocodingServiceProtocol.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

typealias Location = (lat: Double, long: Double)

protocol GeocodingServiceProtocol {
    func geoCodeAddress(_ address: String, completion: ((Result<Location, Error>) -> Void)?)
}
