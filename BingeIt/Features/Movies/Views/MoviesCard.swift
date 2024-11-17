//
//  ContentView.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 16/11/2024.
//

import SwiftUI

struct MoviesCard: View {
    
    @ObservedObject var viewModel: MoviesCardViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading || viewModel.hasError {
                EmptyView()
            } else {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(viewModel.moviesURLs, id: \.self) { url in
                            AsyncImage(url: url, content: { image in
                                image
                                    .imageStyle()
                            }, placeholder: {
                                Image(Constants.placeHolder)
                                    .imageStyle()
                            })
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.loadMovies()
        }
    }
}

extension MoviesCard {
    
    private struct Constants {
        static let placeHolder = "placeholder"
    }
}

#Preview {
    MoviesCard(viewModel: MoviesCardViewModel(service: MoviesService()))
}
