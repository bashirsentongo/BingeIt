//
//  MoviesCardViewModel.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation
import Combine

final class MoviesCardViewModel: ObservableObject {
    
    private var viewState: ViewState?
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var hasError = false
    @Published var moviesURLs: [URL] = []
    
    private var service: MoviesService
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    init(service: MoviesService = MoviesService()) {
        self.service = service
    }
    
    func loadMovies() {
        viewState = .loading
        
        defer { viewState = .finished }
        
        service.fetchMovies()
            .sink(
                receiveCompletion: { [weak self] completion  in
                    switch completion {
                    case .finished:
                        self?.hasError = false
                    case .failure:
                        self?.hasError = true
                    }
                },
                receiveValue: { [weak self] movieResponse in
                    self?.moviesURLs = movieResponse
                        .results
                        .compactMap { $0.backdropURL }
                }
            )
            .store(in: &cancellables)
    }
}
