//
//  Router.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation
import Combine

class Router {
    
    enum NetworkingError: LocalizedError {
        case invalidURL
        case invalidStatusCode(statusCode: Int)
        case noData
        case custom(error: Error?, value: String?)
        case decodingError(error: String)

        var description: String {
            switch self {
            case .invalidURL:
                return "URL isn't valid"
            case .invalidStatusCode(let statusCode):
                return "Status code \(statusCode) falls into the wrong range"
            case .noData:
                return "Sorry couldn't find any Cats"
            case .custom(let error, let value):
                let message = error != nil ? error?.localizedDescription : value
                return "Something went wrong \(message ?? "")"
            case .decodingError(let error):
                return error.description
            }
        }
    }

    func fetchAndDecode<T: Decodable>(from route: EndpointTypeProtocol, model: T.Type) -> AnyPublisher<T, Error> {
        guard let urlRequest = urlRequest(from: route) else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .catch { error -> Fail<T, Error> in
                if let decodingError = error as? DecodingError {
                    return Fail(error: NetworkingError.decodingError(error: decodingError.localizedDescription))
                } else {
                    return Fail(error: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func urlRequest(from route: EndpointTypeProtocol) -> URLRequest? {
        guard let baseURL = route.baseURL else {
            return nil
        }
        
        var components = URLComponents(
            url: baseURL.appendingPathComponent(route.path),
            resolvingAgainstBaseURL: true
        )
        
        if let parameters = route.parameters {
            components?.queryItems = parameters.asQueryItems
        }
        
        guard let url = components?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.httpMethod.value
        urlRequest.allHTTPHeaderFields = HTTPHeaders.headersDict
        
        return urlRequest
    }
}
