//
//  Map.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

final class MapRouter: ViperRouter {
    weak var viewController: UIViewController!
    weak var presenter: MapPresenterProtocol!
}

extension MapRouter: MapRouterProtocol {
}
