//
// Created by Andrew Mysyk on 2019-04-24.
// Copyright (c) 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import Alamofire

enum GitHubRouter: APIRouter {
    case contributors(pageSize: Int)
    case user(name: String)

    var method: HTTPMethod {
        return .get
    }

    var headers: HTTPHeaders? {
        return HTTPHeaders(["Accept": "application/json"])
    }

    var path: String {
        let root = "https://api.github.com/"

        switch self {
        case .contributors:     return root + "repos/apple/swift/contributors"
        case .user(let name):   return root + "users/\(name)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let urlRequest = try URLRequest(url: try asURL(), method: method, headers: headers)

        switch self {
        case .contributors(let pageSize):
            let params: Parameters = [
                "q": "contributions",
                "order": "desc",
                "per_page": pageSize
            ]
            return try URLEncoding.default.encode(urlRequest, with: params)
        default:
            return urlRequest
        }
    }
}
