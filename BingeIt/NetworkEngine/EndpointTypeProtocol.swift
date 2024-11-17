//
//  EndpointTypeProtocol.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation

enum HTTPMethod: String {
    case get

    var value: String {
        rawValue.uppercased()
    }
}

typealias Parameters = [String: Any]

extension Parameters {
    var asQueryItems: [URLQueryItem] {
        map { URLQueryItem(name: $0, value: "\($1)") }
    }
}

protocol EndpointTypeProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
}
