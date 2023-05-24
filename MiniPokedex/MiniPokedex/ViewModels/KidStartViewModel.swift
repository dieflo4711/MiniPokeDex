//
//  KidStartViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

class KidStartViewModel: ObservableObject {
    @Published var pokemon: PokemonDisplay?
    
    func getSelectedPokemon() async {
        let mainPokemon = getSelected()
        let displayPokemon = await getDisplayData(for: mainPokemon?.name)
        
        DispatchQueue.main.async {
            self.pokemon = displayPokemon
        }
    }
    
    func getSelected() -> Pokemon? {
        return PokemonService.shared.getSelectedPokemon()
    }
    
    func getDisplayData(for name: String?) async -> PokemonDisplay? {
        return await PokemonService.shared.getDisplayData(for: name)
    }
}
