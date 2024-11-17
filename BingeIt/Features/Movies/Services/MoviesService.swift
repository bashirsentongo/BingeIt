//
//  MoviesService.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchMovies() -> AnyPublisher<MovieResponse, Error>
}

class MoviesService: MovieServiceProtocol {
    
    private let router = Router()
    
    func fetchMovies() -> AnyPublisher<MovieResponse, Error> {
        router.fetchAndDecode(from: MoviesEndpoint.movies, model: MovieResponse.self)
    }
}
