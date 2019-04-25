//
//  ActivityIndication.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import PKHUD

protocol ActivityIndication {
    func showActivityIndicator()
    func hideIndicator()
}

extension ActivityIndication where Self: UIViewController {
    func showActivityIndicator() {
        HUD.show(.progress)
    }
    func hideIndicator() {
        HUD.hide()
    }
}
