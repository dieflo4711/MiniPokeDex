//
//  ParentStartView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

import SwiftUI

struct ParentStartView: View {
    @StateObject private var viewModel = ParentStartViewModel()

    var body: some View {
        NavigationView {
            mainContentView
        }
        .onAppear {
            Task {
                await viewModel.getPokemon()
            }
        }
    }
    
    private var mainContentView: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                Text(pokemon.name.uppercased())
                    .font(.title)
                    .foregroundColor(.blue)
                
                pokemonImageView(with: pokemon.sprite)
                buttonView
                Spacer()
            } else {
                Text("Fetching Pokémon...")
                    .font(.title)
                    .padding()
            }
        }
    }
    
    private func pokemonImageView(with imageUrl: String) -> some View {
        let pokemonImageURL = URL(string: imageUrl)
        return ZStack(alignment: .topTrailing) {
            AsyncImage(url: pokemonImageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 280, height: 280)
                case .failure(let error):
                    Text("Failed to load image: \(error.localizedDescription)")
                @unknown default:
                    Text("Unknown image loading state")
                }
            }
            .background(.thinMaterial)
            .clipShape(Circle())
        }
    }
    
    private var buttonView: some View {
        Button(action: {
            Task {
                await viewModel.getPokemon()
            }
        }) {
            Text("Change")
                .font(.title3)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private func pokemonTitle() -> String {
        if let pokemon = viewModel.pokemon {
            return pokemon.name.uppercased()
        }
        
        return ""
    }
}

struct ParentStartView_Previews: PreviewProvider {
    static var previews: some View {
        ParentStartView()
    }
}

