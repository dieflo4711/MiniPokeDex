//
//  SelectedPokemonViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

class SelectedPokemonViewModel: ObservableObject {
    @Published var pokemon: PokemonDetails?
    @Published var bookmarked = false
    @Published var isSelected = false
    
    func getSelectedPokemon() {
        pokemon = PokemonService.shared.getSelectedPokemon()
        
        if let pokemon = self.pokemon {
            isSelected = true
            bookmarked = isBookmarked(pokemon)
        }
    }
    
    func isSelected(_ pokemon: PokemonDetails) -> Bool {
        return PokemonService.shared.isSelected(pokemon)
    }
    
    func toggleSelected() {
        isSelected = PokemonService.shared.toggleSelected(pokemon)
    }
    
    func isBookmarked(_ pokemon: PokemonDetails) -> Bool {
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

    func removeBookmark(_ pokemon: PokemonDetails) {
        PokemonService.shared.removePokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func addBookmark(_ pokemon: PokemonDetails) {
        PokemonService.shared.addPokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
}

