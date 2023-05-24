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
    @Published var isSelected = false
    
    func getPokemon() async {
        let randomPokemon = await getRandomPokemon()
        let displayPokemon = await getDisplayData(for: randomPokemon?.name)
        let pokemon = Pokemon(name: randomPokemon?.name ?? "",
                              url: displayPokemon?.sprite ?? "")
        
        DispatchQueue.main.async {
            self.pokemon = displayPokemon
            self.bookmarked = self.isBookmarked(pokemon)
            self.isSelected = self.isSelected(self.pokemon)
        }
    }
    
    func getRandomPokemon() async -> Pokemon? {
        return await PokemonService.shared.getRandomPokemon()
    }
    
    func getDisplayData(for name: String?) async -> PokemonDisplay? {
        return await PokemonService.shared.getDisplayData(for: name)
    }
    
    func isBookmarked(_ pokemon: Pokemon) -> Bool {
        return PokemonService.shared.isBookmarked(pokemon)
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
    
    func removeBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.removePokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func addBookmark(_ pokemon: Pokemon) {
        PokemonService.shared.addPokemonBookmark(for: pokemon)
        bookmarked.toggle()
    }
    
    func isSelected(_ pokemon: PokemonDisplay?) -> Bool {
        guard let pokemon = self.pokemon else { return false }
        return PokemonService.shared.isSelected(pokemon.name)
    }
    
    func toggleSelected() {
        guard let pokemon = self.pokemon else { return }
        
        if isSelected(pokemon) {
            unselectPokemon()
            isSelected = false
        } else {
            let pokemon = Pokemon(name: pokemon.name, url: pokemon.sprite)
            PokemonService.shared.selectPokemon(pokemon)
            isSelected = true
        }
    }
    
    func unselectPokemon() {
        PokemonService.shared.unselectPokemon()
    }
}
