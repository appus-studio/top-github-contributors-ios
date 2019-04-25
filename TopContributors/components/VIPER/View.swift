//
//  View.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

public protocol ViperView where Self: UIViewController {
    associatedtype Presenter
    var presenter: Presenter! { get set }
    var viperComponents: VIPERComponents! { get set }
}
