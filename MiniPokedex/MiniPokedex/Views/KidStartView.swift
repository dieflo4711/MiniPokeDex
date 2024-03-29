//
//  KidStartView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct KidStartView: View {
    @StateObject private var viewModel = KidStartViewModel()
    
    var body: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                TitleView(name: pokemon.name)
                    .padding(.top, 30)
                
                ImageView(url: pokemon.image)
                
                TypeView(type: pokemon.type)
                
                StatsView(stats: pokemon.stats)
                
                Spacer()
            } else {
                Text("Pick a Pokemon and come back!")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            Task {
                await viewModel.getSelectedPokemon()
            }
        }
    }
}

struct KidStartView_Previews: PreviewProvider {
    static var previews: some View {
        KidStartView()
    }
}

