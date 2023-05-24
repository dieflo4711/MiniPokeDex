//
//  SelectedViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

class SelectedViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    
    @Published var bookmarked = false
    @Published var isSelected = false
    
    func getSelectedPokemon() {
        pokemon = getSelected()
        if let pokemon = self.pokemon {
            isSelected = isSelected(pokemon)
            bookmarked = isBookmarked(pokemon)
        }
    }
    
    func getSelected() -> Pokemon? {
        return PokemonService.shared.getSelectedPokemon()
    }
    
    func isSelected(_ pokemon: Pokemon) -> Bool {
        return PokemonService.shared.isSelected(pokemon.name)
    }
    
    func toggleSelected() {
        guard let pokemon = self.pokemon else { return }
        
        if isSelected(pokemon) {
            unselectPokemon()
            isSelected = false
        } else {
            PokemonService.shared.selectPokemon(pokemon)
            isSelected = true
        }
    }
    
    func unselectPokemon() {
        PokemonService.shared.unselectPokemon()
    }
    
    func isBookmarked(_ pokemon: Pokemon) -> Bool {
        return PokemonService.shared.isBookmarked(pokemon)
    }
    
    func toggleBookmark() {
        if let pokemon = pokemon {
            if bookmarked {
                removeBookmark(pokemon)
            } else {
                addBookmark(pokemon)
            }
        }
    }

    func removeBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.removePokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func addBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.addPokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
}

