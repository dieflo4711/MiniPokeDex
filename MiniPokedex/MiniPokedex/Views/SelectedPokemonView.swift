//
//  SelectedPokemonView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

struct SelectedPokemonView: View {
    @StateObject private var viewModel = SelectedPokemonViewModel()
    
    var body: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                TitleView(name: pokemon.name)
                    .padding(.top, 20)
                
                ImageView(url: pokemon.image)
                
                TypeView(type: pokemon.type)
                
                StatsView(stats: pokemon.stats)
                
                Button(action: {
                    viewModel.toggleSelected()
                }) {
                    Text(viewModel.isSelected ? "Unselect" : "Select")
                        .font(.title3)
                        .bold()
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.isSelected ? Color.blue : Color.black, lineWidth: 1)
                        )
                        .background(viewModel.isSelected ? Color.blue : Color.clear)
                        .foregroundColor(viewModel.isSelected ? .white : Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 30)
                Spacer()
            } else {
                Text("You have not selected a Pokémon")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            viewModel.getSelectedPokemon()
        }
        .toolbar {
            toggleBookmarkButton
        }
    }
    
    private var toggleBookmarkButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                viewModel.toggleBookmark()
            }) {
                Image(systemName: viewModel.bookmarked ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
    }
}

struct SelectedPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPokemonView()
    }
}

