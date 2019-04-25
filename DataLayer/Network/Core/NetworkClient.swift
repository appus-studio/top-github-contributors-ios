//
// Created by Andrew Mysyk on 4/19/18.
// Copyright (c) 2018 Appus Studio LLC. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkClient: class {
    @discardableResult
    func performRequest<T: Decodable>(to url: URLRequestConvertible, completion: ((Result<T, Error>) -> Void)?) -> Request

    @discardableResult
    func downloadRequest(url: URLRequestConvertible, to: URL, completion: ((Result<URL?, Error>) -> Void)?) -> Request
}
