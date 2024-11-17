//
//  Movie.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "\(Constants.imageURL)\(path)")
    }
    
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "\(Constants.imageURL)\(path)")
    }
}

extension Movie {
    
    private struct Constants {
        static let imageURL = "https://image.tmdb.org/t/p/w500"
    }
}
