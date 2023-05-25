//
//  BookmarkListView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct BookmarkListView: View {
    @StateObject private var viewModel = BookmarkListViewModel()
    @State private var selectedRow: Int? = nil
    @State private var isShowingDetail = false
    
    init() {
        // Adds color to the header
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.blue)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        VStack {
            if let bookmarkedPokemon = viewModel.bookmarkedPokemon {
                if bookmarkedPokemon.isEmpty {
                    Text("No bookmarked pokemons")
                        .font(.title)

                } else {
                    VStack {
                        Text("Bookmarked Pokémon")
                            .font(.title)
                            .bold()
                            .padding(.bottom, -15)
                        List {
                            ForEach(bookmarkedPokemon.indices, id: \.self) { index in
                                let pokemon = bookmarkedPokemon[index]
                                HStack {
                                    if let url = URL(string: pokemon.image) {
                                        pokemonImageView(for: url)
                                    } else {
                                        Image(systemName: "questionmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    Text(pokemon.name.capitalized)
                                        .font(.title2)
                                }
                                .onTapGesture {
                                    selectedRow = index
                                    isShowingDetail = true
                                }
                                .tag(index)
                            }
                        }
                        .sheet(isPresented: Binding(
                            get: { isShowingDetail },
                            set: { newValue in
                                if !newValue {
                                    selectedRow = nil // Reset selectedRow after dismissal
                                    isShowingDetail = newValue
                                    viewModel.getBookmarkedPokemon()
                                }
                            }
                        )) {
                            if let row = selectedRow {
                                BookmarkDetailView(isShowingDetail: $isShowingDetail, pokemon: bookmarkedPokemon[row])
                            }
                        }
                    }
                    .padding(.top, 25)
                    .background(Color(UIColor.systemGroupedBackground))
                }
            }
        }
        .onAppear {
            viewModel.getBookmarkedPokemon()
        }
    }
    
    private func pokemonImageView(for url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            @unknown default:
                Text("Unknown image loading state")
            }
        }
    }
    
    private func unbookmarkButton(for bookmarkedPokemon: [PokemonDetails]) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if !bookmarkedPokemon.isEmpty {
                Button(action: {
                    viewModel.removeAllBookmarks()
                }) {
                    Image(systemName: "trash")
                }
            }
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
    }
}
