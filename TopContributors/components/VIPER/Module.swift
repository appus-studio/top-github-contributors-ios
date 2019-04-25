//
//  ViperRouter.swift
//
//  Created by Andrew Mysyk on 4/17/18.
//  Copyright © 2018 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

open class Module<View: ViperView, Presenter: ViperPresenter, Interactor: ViperInteractor, Router: ViperRouter> {
    var view: View!
    var interactor: Interactor!
    var presenter: Presenter!
    var router: Router!
    internal init() {
        self.build()
    }
    private func build() {
        let storyboardName = String(describing: View.self)
        let bundle = Bundle(for: View.self)
        guard let viewController = UIStoryboard(name: storyboardName, bundle: bundle).instantiateInitialViewController() as? View else {
            fatalError("Please check your storyboard for '\(storyboardName)'")
        }
        view = viewController
        router = Router()
        interactor = Interactor()
        presenter = Presenter()
        // Assemble
        guard let viperView = view as? Presenter.View,
            let viperInteractor = interactor as? Presenter.Interactor,
            let viperRouter = router as? Presenter.Router,
            let viperRouterPresenter = presenter as? Router.Presenter,
            let viperViewPresenter = presenter as? View.Presenter,
            let viperInteractorPresenter = presenter as? Interactor.Presenter else {
                fatalError("Incompatible types.")
        }
        presenter.view = viperView
        presenter.interactor = viperInteractor
        presenter.router = viperRouter
        view.presenter = viperViewPresenter
        interactor.presenter = viperInteractorPresenter
        router.presenter = viperRouterPresenter
        router.viewController = view
        // View retains all components
        view.viperComponents = VIPERComponents(interactor: interactor, presenter: presenter, router: router)
    }
}
