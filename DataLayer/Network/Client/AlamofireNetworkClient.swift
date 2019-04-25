//
// Created by Andrew Mysyk on 4/19/18.
// Copyright (c) 2018 Appus Studio LLC. All rights reserved.
//

import Foundation
import Alamofire

final class AlamofireNetworkClient: NetworkClient {

    @discardableResult
    func performRequest<T: Decodable>(to url: URLRequestConvertible, completion: ((Result<T, Error>) -> Void)?) -> Request {
        let defaultDecoder = JSONDecoder()
        return performRequest(to: url, decoder: defaultDecoder, completion: completion)
    }

    @discardableResult
    func performRequest<T: Decodable>(to url: URLRequestConvertible, decoder: JSONDecoder, completion: ((Result<T, Error>) -> Void)?) -> Request {
        let task = AF.request(url).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completion?(.success(result))
                } catch {
                    print("decoding error:\n\(error)")
                    completion?(.failure(error))
                }
            case let .failure(error):
                completion?(.failure(error))
            }
        }
#if DEBUG
        print(task.debugDescription)
#endif
        return task
    }

    func downloadRequest(url: URLRequestConvertible, to: URL, completion: ((Result<URL?, Error>) -> Void)?) -> Request {
        let task = AF.download(url) { (url: URL, response: HTTPURLResponse) -> (destinationURL: URL, options: DownloadRequest.Options) in
            return (to, [.createIntermediateDirectories, .removePreviousFile])
        }.validate(statusCode: 200..<300).response { response in
            if let error = response.error {
                completion?(.failure(error))
            } else {
                completion?(.success(response.fileURL))
            }
        }
        return task
    }
}
