//
//  KidStartViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

class KidStartViewModel: ObservableObject {
    @Published var pokemon: PokemonDetails?
    
    func getSelectedPokemon() async {
        let pokemon = PokemonService.shared.getSelectedPokemon()
        
        DispatchQueue.main.async {
            self.pokemon = pokemon
        }
    }
}
