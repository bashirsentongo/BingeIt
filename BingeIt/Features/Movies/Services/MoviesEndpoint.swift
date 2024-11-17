//
//  MoviesEndpoint.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation

enum MoviesEndpoint {
    case movies
}

extension MoviesEndpoint: EndpointTypeProtocol {
    
    var baseURL: URL? {
        URL(string: APIConstants.baseURL)
    }
    
    var path: String {
        switch self {
        case .movies:
            return "/movie/popular"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .movies:
            return .get
        }
    }
    
    var parameters: Parameters? {
        ["page": "1", "language": "en-US"]
    }
}
