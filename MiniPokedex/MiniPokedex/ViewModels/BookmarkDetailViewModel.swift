//
//  BookmarkDetailViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class BookmarkDetailViewModel: ObservableObject {
    @Published var bookmarked = false
    
    func isBookmarked(_ pokemon: PokemonDetails) {
        bookmarked = PokemonService.shared.isBookmarked(pokemon)
    }
    
    func removeBookmark(_ pokemon: PokemonDetails) {
        PokemonService.shared.removePokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func addBookmark(_ pokemon: PokemonDetails) {
        PokemonService.shared.addPokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func toggleBookmark(for pokemon: PokemonDetails) {
        if bookmarked {
            removeBookmark(pokemon)
        } else {
            addBookmark(pokemon)
        }
    }
}

