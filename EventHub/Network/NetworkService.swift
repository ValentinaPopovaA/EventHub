//
//  NetworkService.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

final class NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: request.url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        urlComponents.queryItems = request.queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decodedResponse = try request.decode(data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
