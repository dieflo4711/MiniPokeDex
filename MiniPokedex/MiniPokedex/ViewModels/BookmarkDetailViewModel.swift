//
//  BookmarkDetailViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class BookmarkDetailViewModel: ObservableObject {
    @Published var bookmarked = false
    
    func prepareViewModel(_ pokemon: Pokemon) {
        isBookmarked(pokemon)
    }
    
    func removeBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.removePokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func addBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.addPokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func isBookmarked(_ pokemon: Pokemon) {
        bookmarked = PokemonService.shared.isBookmarked(pokemon)
    }
    
    func getBookmarkedPokemon() -> Binding<[Pokemon]> {
        return Binding<[Pokemon]>(
            get: { PokemonService.shared.fetchBookmarked() },
            set: { _ in }
        )
    }
}

