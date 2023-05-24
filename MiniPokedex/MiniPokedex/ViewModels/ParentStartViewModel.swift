//
//  ParentStartViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class ParentStartViewModel: ObservableObject {
    @Published var pokemon: PokemonDisplay?
    
    func getPokemon() async {
        let randomPokemon = await PokemonService.shared.getRandomPokemon()
        let displayPokemon = await PokemonService.shared.getDisplayData(for: randomPokemon?.name)
        let pokemon = Pokemon(name: randomPokemon?.name ?? "",
                              url: displayPokemon?.sprite ?? "")
        
        DispatchQueue.main.async {
            self.pokemon = displayPokemon
        }
    }
}
