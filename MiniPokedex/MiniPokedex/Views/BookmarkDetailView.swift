//
//  BookmarkDetailView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct BookmarkDetailView: View {
    @StateObject private var viewModel = BookmarkDetailViewModel()
    @State private var sheetHeight: CGFloat = .zero
    @Binding var isShowingDetail: Bool
    let pokemon: PokemonDetails
    
    var body: some View {
        VStack {
            headerButtons
            
            TitleView(name: pokemon.name)
            
            ImageView(url: pokemon.image)
            
            TypeView(type: pokemon.type)
            
            StatsView(stats: pokemon.stats)
            
            SelectedPokemonButtonView(isSelected: viewModel.isSelected,
                                      toggleSelected: { viewModel.toggleSelected(for: pokemon) })
            .padding(.top, 20)
        }
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            sheetHeight = newHeight
        }
        .presentationDetents([.height(sheetHeight)])
        .onAppear {
            viewModel.prepareViewModel(pokemon)
        }
    }
    
    private var headerButtons: some View {
        HStack {
            Button(action: {
                viewModel.toggleBookmark(for: pokemon)
            }) {
                Image(systemName: viewModel.bookmarked ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                closeSheet()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
    
    private func closeSheet() {
        isShowingDetail = false
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct BookmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let stats = PokemonStats(hp: 100, attack: 80, defense: 70, specialAttack: 120, specialDefense: 90, speed: 95)
        let pokemonDetails = PokemonDetails(name: "Pikachu",
                                            image: "pikachu_sprite.png",
                                            stats: stats,
                                            type: ["Electric"])
        return BookmarkDetailView(isShowingDetail: .constant(true), pokemon: pokemonDetails)
    }
}
