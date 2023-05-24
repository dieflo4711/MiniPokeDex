//
//  ParentStartViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class ParentStartViewModel: ObservableObject {
    @Published var pokemon: PokemonDisplay?
    @Published var bookmarked = false
    
    func getPokemon() async {
        let randomPokemon = await PokemonService.shared.getRandomPokemon()
        let displayPokemon = await PokemonService.shared.getDisplayData(for: randomPokemon?.name)
        let pokemon = Pokemon(name: randomPokemon?.name ?? "",
                              url: displayPokemon?.sprite ?? "")
        
        DispatchQueue.main.async {
            self.pokemon = displayPokemon
            self.bookmarked = self.isBookmarked(pokemon)
        }
    }
    
    func isBookmarked(_ pokemon: Pokemon) -> Bool {
        return PokemonService.shared.isBookmarked(pokemon)
    }
    
    func removeBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.removePokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func toggleBookmark() {
        if let name = pokemon?.name, let sprite = pokemon?.sprite {
            let pokemon = Pokemon(name: name, url: sprite)
            if bookmarked {
                removeBookmark(pokemon)
            } else {
                addBookmark(pokemon)
            }
        }
    }
    
    func addBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.addPokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
}
