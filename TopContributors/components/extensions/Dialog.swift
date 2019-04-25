//
//  Dialog.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/25/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import PKHUD

protocol Dialog {
    func showError(message: String)
}

extension Dialog where Self: UIViewController {
    func showError(message: String) {
        HUD.flash(.labeledError(title: nil, subtitle: message), delay: 2)
    }
}
