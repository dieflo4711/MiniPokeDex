//
//  BookmarkDetailViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class BookmarkDetailViewModel: ObservableObject {
    @Published var bookmarked = false
    @Published var isSelected = false
    
    func prepareViewModel(_ pokemon: PokemonDetails) {
        bookmarked = isBookmarked(pokemon)
        isSelected = isSelected(pokemon)
    }
    
    func isBookmarked(_ pokemon: PokemonDetails) -> Bool {
        return PokemonService.shared.isBookmarked(pokemon)
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
    
    // Selected Pokémon functions
    
    func isSelected(_ pokemon: PokemonDetails) -> Bool {
        return PokemonService.shared.isSelected(pokemon.name)
    }
    
    func toggleSelected(for pokemon: PokemonDetails) {
        if isSelected(pokemon) {
            unselectPokemon()
            isSelected = false
        } else {
            selectPokemon(pokemon)
            isSelected = true
        }
    }
    
    func unselectPokemon() {
        PokemonService.shared.unselectPokemon()
    }
    
    func selectPokemon(_ pokemon: PokemonDetails) {
        PokemonService.shared.selectPokemon(pokemon)
    }
}

