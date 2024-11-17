//
//  HomeScreenView.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                MoviesCard(viewModel: MoviesCardViewModel())
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    HomeScreenView()
}
