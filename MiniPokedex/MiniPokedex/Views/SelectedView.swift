//
//  SelectedView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

struct SelectedView: View {
    @StateObject private var viewModel = SelectedViewModel()
    
    var body: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                Text(pokemon.name.capitalized)
                    .font(.title)
                    .padding(.top, 20)
                
                ImageView(url: pokemon.url)
                
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
                .padding(.top, 20)
                Spacer()
            } else {
                Text("YOu have not selected a Pokémon")
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

struct SelectedView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedView()
    }
}

