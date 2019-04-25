//
//  ContributorsListPresenter.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

final class ContributorsListPresenter: ViperPresenter {
    weak var view: ContributorsListViewProtocol!
    weak var interactor: ContributorsListInteractorProtocol!
    weak var router: ContributorsListRouterProtocol!

    var isFirstLaunch = true
}

extension ContributorsListPresenter: ContributorsListPresenterProtocol {
    func refreshAction() {
        refreshContributors()
    }
    func tapedLocationButton(index: Int) {
        self.view.showActivityIndicator()
        let contributor = self.interactor.contributers[index]
        self.interactor.fetchContributorLocation(contributor: contributor) { (result) in
            self.view.hideIndicator()
            switch result {
            case .success(let location):
                let name = self.interactor.contributers[index].login
                self.router.showMap(location: location, name: name)
            case .failure :
                self.view.showError(message: R.string.localizable.userHasNoLocation())
            }
        }
    }
    func contributor(index: Int) -> ContributorListUserEntity {
        return self.interactor.contributers[index]
    }
    var contributorsCount: Int {
        return self.interactor.contributers.count
    }
    func viewDidAppear() {
        if isFirstLaunch {
            refreshContributors()
            self.isFirstLaunch = false
        }
    }
    func refreshContributors() {
        self.view.showActivityIndicator()
        self.interactor.fetchContributors(first: 25) { (results) in
            self.view.hideIndicator()
            switch results {
            case .success:
                self.view.reloadData()
                self.view.hideRefresher()
                self.view.hideTroubleView()
            case .failure:
                self.view.showError(message: R.string.localizable.cannotFetchData())
                self.view.hideRefresher()
                self.view.showTroubleView()
            }
        }
    }
}
