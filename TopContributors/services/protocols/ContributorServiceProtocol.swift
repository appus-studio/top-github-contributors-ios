//
//  ContributorServiceProtocol.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol ContributorServiceProtocol {
    func getContributors(first: Int, completion: ((Result<[ContributorListUserEntity], Error>) -> Void)?)
    func getUser(name: String, completion: ((Result<ContributorListUserDetailsEntity, Error>) -> Void)?)
}
