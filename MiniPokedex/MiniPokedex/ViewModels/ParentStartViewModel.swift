//
//  ParentStartViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class ParentStartViewModel: ObservableObject {
    @Published var pokemon: PokemonDetails?
    @Published var bookmarked = false
    @Published var isSelected = false
    
    func getPokemon() async {
        let randomPokemon = await getRandomPokemon()
        let pokemon = await getDisplayData(for: randomPokemon?.name)
        
        DispatchQueue.main.async {
            self.pokemon = pokemon
            self.bookmarked = self.isBookmarked(pokemon)
            self.isSelected = self.isSelected(pokemon)
        }
    }
    
    func getRandomPokemon() async -> Pokemon? {
        return await PokemonService.shared.getRandomPokemon()
    }
    
    func getDisplayData(for name: String?) async -> PokemonDetails? {
        return await PokemonService.shared.getDisplayData(for: name)
    }
    
    func isBookmarked(_ pokemon: PokemonDetails?) -> Bool {
        guard let pokemon = pokemon else { return false }
        return PokemonService.shared.isBookmarked(pokemon)
    }
    
    func toggleBookmark() {
        guard let pokemon = self.pokemon else { return }
        if bookmarked {
            removeBookmark(pokemon)
        } else {
            addBookmark(pokemon)
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
    
    func isSelected(_ pokemon: PokemonDetails?) -> Bool {
        guard let pokemon = self.pokemon else { return false }
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
}
