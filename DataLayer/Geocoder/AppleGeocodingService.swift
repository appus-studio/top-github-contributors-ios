//
//  AppleGeocodingService.swift
//  DataLayer
//
//  Created by Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import CoreLocation

public enum GeocodingError: Error {
    case noLocation
}

public class AppleGeocodingService: NSObject {
    public typealias Coordinates = (lat: Double, long: Double)

    let geocoder = CLGeocoder()

    public func geoCodeAddress(_ address: String, completion: ((Result<Coordinates, Error>) -> Void)?) {

        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                completion?(.failure(error))
            } else {
                guard let location = placemarks?.first?.location else {
                    completion?(.failure(GeocodingError.noLocation))
                    return
                }
                let coordinates = (lat: location.coordinate.latitude, long: location.coordinate.longitude)
                completion?(.success(coordinates))
            }
        }
    }
}
