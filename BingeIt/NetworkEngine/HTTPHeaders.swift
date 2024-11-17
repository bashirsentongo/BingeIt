//
//  HTTPHeader.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation

enum HTTPHeaders {
    static var headersDict: [String: String] {
        [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOWZjNDk5ZjNiODdlOTMwZmU1ZTI3MTM1MzJkM2VhZSIsIm5iZiI6MTczMTgzNTM4MS45OTA1MDk3LCJzdWIiOiI2NmE3NjQ1ZTFiNWZhZGI0NTVhYmFlMzgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.kA1L6VgGKNeiPrfzUxthLqSVtNaQfo6uFs8RSne9aZY"
        ]
    }
}
