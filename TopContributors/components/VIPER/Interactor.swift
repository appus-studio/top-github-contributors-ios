//
//  Interactor.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

public protocol ViperInteractor: class {
    associatedtype Presenter
    var presenter: Presenter! { get set }
    init()
}
