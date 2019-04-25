//
//  ContributorsListProtocols.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol ContributorsListPresenterProtocol: class {
    func viewDidAppear()
    func refreshAction()
    var contributorsCount: Int {get}
    func contributor(index: Int) -> ContributorListUserEntity
    func tapedLocationButton(index: Int)
}

protocol ContributorsListViewProtocol: class, ActivityIndication, Dialog {
    func reloadData()
    func hideRefresher()
    func showTroubleView()
    func hideTroubleView()
}

protocol ContributorsListInteractorProtocol: class {
    func fetchContributors(first: Int, completion: ((Result<[ContributorListUserEntity], Error>) -> Void)?)
    func fetchContributorLocation(contributor: ContributorListUserEntity, completion: ((Result<Location, Error>) -> Void)?)

    var contributers: [ContributorListUserEntity] {get}
}

protocol ContributorsListRouterProtocol: class {
    func showMap(location: Location, name: String)
}
