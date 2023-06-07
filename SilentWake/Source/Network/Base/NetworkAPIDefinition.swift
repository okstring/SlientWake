//
//  NetworkAPIDefinition.swift
//  PhotoWidget
//
//  Created by Ok Hyeon Kim on 2023/04/06.
//

import Foundation

import RxSwift
import RxCocoa

public protocol NetworkAPIDefinition {
    typealias URLInfo = NetworkAPI.URLInfo
    typealias RequestInfo = NetworkAPI.RequestInfo

    associatedtype Parameter: Encodable
    associatedtype Response: Decodable

    var urlInfo: URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
}

public extension NetworkAPIDefinition {
    var session: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.waitsForConnectivity = true
        return URLSession(configuration: config)
    }

    var urlRequest: URLRequest {
        let url = urlInfo.url
        return requestInfo.requests(url: url)
    }

    func request() -> Single<Response> {
        return Single.create { observer -> Disposable in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    observer(.failure(NetworkError(.noData)))
                    return
                }

                do {
                    let decodeResponse = try JSONDecoder().decode(Response.self, from: data)
                    Log.custom("url: \(urlRequest.url?.absoluteString ?? "")\n\(decodeResponse)", header: "🚀 Success!!")
                    observer(.success(decodeResponse))
                } catch {
                    Log.error(error.localizedDescription)
                    observer(.failure(error))
                }
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
        .observe(on: MainScheduler.asyncInstance)
    }

    func requestData() -> Single<Data> {
        return Single.create { observer -> Disposable in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    observer(.failure(NetworkError(.noData)))
                    return
                }
                Log.custom("url: \(urlRequest.url?.absoluteString ?? "")", header: "🚀 Success!!")
                observer(.success(data))
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
}
