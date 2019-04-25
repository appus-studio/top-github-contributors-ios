//
// Created by Andrew Mysyk on 2019-04-24.
// Copyright (c) 2019 Appus Studio LP. All rights reserved.
//

import Foundation

public class GitHubService: NSObject {

    let client = AlamofireNetworkClient()

    public func getContributors(first: Int, completion: ((Result<[User], Error>) -> Void)?) {
        client.performRequest(to: GitHubRouter.contributors(pageSize: first), completion: completion)
    }

    public func getUser(name: String, completion: ((Result<UserDetails, Error>) -> Void)?) {
        client.performRequest(to: GitHubRouter.user(name: name), completion: completion)
    }
}
