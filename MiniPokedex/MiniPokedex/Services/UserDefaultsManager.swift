//
//  UserDefaultsManager.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let key = "Pokemon"
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func save(_ pokemonDetails: PokemonDetails) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(pokemonDetails) {
                defaults.set(encoded, forKey: key)
            }
        }
    
    func load() -> PokemonDetails? {
        if let savedData = defaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let loadedPokemonDetails = try? decoder.decode(PokemonDetails.self, from: savedData) {
                return loadedPokemonDetails
            }
        }
        return nil
    }
    
    func isSaved(with name: String) -> Bool {
        let savedPokemonDetails = load()
        return (savedPokemonDetails?.name == name)
    }
    
    func clear() {
        defaults.removeObject(forKey: key)
    }
}
