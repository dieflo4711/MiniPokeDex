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
    
    func save(_ pokemon: Pokemon) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pokemon) {
            defaults.set(encoded, forKey: key)
        }
    }
    
    func load() -> Pokemon? {
        if let savedData = defaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let loadedPokemon = try? decoder.decode(Pokemon.self, from: savedData) {
                return loadedPokemon
            }
        }
        // Return default values if no saved data exists
        return nil
    }
    
    func isSaved(with name: String) -> Bool {
        let savedPokemon = load()
        return (savedPokemon?.name == name)
    }
    
    func clear() {
        defaults.removeObject(forKey: key)
    }
}
