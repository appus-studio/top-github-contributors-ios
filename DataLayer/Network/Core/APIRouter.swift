//
// Created by Andrew Mysyk on 4/19/18.
// Copyright (c) 2018 Appus Studio LLC. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible, URLConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
}

extension APIRouter {

    func asURL() throws -> URL {
        return try path.asURL()
    }

    var headers: HTTPHeaders? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        return try URLRequest(url: try asURL(), method: method, headers: headers)
    }
}
