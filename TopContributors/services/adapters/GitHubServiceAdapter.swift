//
//  GitHubServiceAdapter.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import DataLayer

extension UserDetails: ContributorListUserDetailsEntity {}
extension User: ContributorListUserEntity {}

class GitHubServiceAdapter: ContributorServiceProtocol {
    var service = GitHubService()
    func getContributors(first: Int, completion: ((Result<[ContributorListUserEntity], Error>) -> Void)?) {
        service.getContributors(first: first) { (result) in
            switch result {
            case .failure(let error):
                    completion?(.failure(error))
            case .success(let users):
                    completion?(.success(users))
            }
        }
    }
    func getUser(name: String, completion: ((Result<ContributorListUserDetailsEntity, Error>) -> Void)?) {
        service.getUser(name: name) { (result) in
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let user):
                completion?(.success(user))
            }
        }
    }
}
