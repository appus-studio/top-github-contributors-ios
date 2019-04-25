//
//  ContributorsListRouter.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

final class ContributorsListRouter: ViperRouter {
    weak var viewController: UIViewController!
    weak var presenter: ContributorsListPresenterProtocol!
}

extension ContributorsListRouter: ContributorsListRouterProtocol {
    func showMap(location: Location, name: String) {
        let mapModule = Modules.map(location: location, name: name)
        self.viewController.show(mapModule.view, sender: nil)
    }
}
