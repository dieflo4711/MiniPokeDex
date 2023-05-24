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
                
                ImageView(url: pokemon.url)
                
                Button(action: {
                    viewModel.toggleSelected()
                }) {
                    Text("Use")
                        .font(.title3)
                        .padding()
                        .background(viewModel.isSelected ? Color.green : Color.clear)
                        .foregroundColor(viewModel.isSelected ? .white : Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.isSelected ? Color.green : Color.black, lineWidth: 1)
                        )
                }
                Spacer()
            } else {
                Text("Your are currently not using a Pokemon")
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
                Image(systemName: viewModel.bookmarked ? "bookmark.fill" : "bookmark")
                    .font(.title2)
                    .padding()
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

