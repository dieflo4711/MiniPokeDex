//
//  PokemonService.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class PokemonService {
    static let shared = PokemonService()
    private let coreDataManager = CoreDataManager.shared
    private let limit = 500
    
    private func fetchPokemons() async throws -> [Pokemon] {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=" + String(limit))!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Pokemons.self, from: data)
        return response.results
    }
    
    private func fatchPokemonData(for name: String) async throws -> PokemonData {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + name)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PokemonData.self, from: data)
        return response
    }
    
    private func getData(for name: String?) async -> PokemonData? {
        guard let name = name else {
            return nil
        }
        
        do {
            let pokemonData = try await fatchPokemonData(for: name)
            return pokemonData
        } catch {
            print("Error fetching Pokemon data: \(error)")
            return nil
        }
    }
    
    func getRandomPokemon() async -> Pokemon? {
        let pokemons = await getPokemons()
        let randomPokemon = pokemons?.randomElement()
        
        guard let randomPokemon = randomPokemon else {
            return nil
        }
        
        removePokemon(withName: randomPokemon.name)
        return randomPokemon
    }
    
    func getPokemons() async -> [Pokemon]? {
        do {
            let coreData = try await fetchPokemons()
            
            if coreData.isEmpty {
                let fetchedPokemons = try await fetchPokemons()
                addPokemons(fetchedPokemons)
                
                return fetchedPokemons
            } else {
                return coreData
            }
        } catch {
            print("Error fetching Pokemons: \(error)")
            return nil
        }
    }
    
    func getDisplayData(for pokemonName: String?) async -> PokemonDisplay? {
        guard let name = pokemonName else { return nil }
        
        let pokemonData = await getData(for: name)
        let stats = pokemonData?.stats.reduce(into: [String: Int]()) { dict, stats in
            dict[stats.stat.name] = stats.base_stat
        }
            
        let pokemonStats = PokemonStats(hp: stats?["hp"] ?? 0,
                                        attack: stats?["attack"] ?? 0,
                                        defense: stats?["defense"] ?? 0,
                                        specialAttack: stats?["special-attack"] ?? 0,
                                        specialDefense: stats?["special-defense"] ?? 0,
                                        speed: stats?["speed"] ?? 0)
            
        let pokeTypes = pokemonData?.types.map { $0.type.name } ?? []
        
        let pokemonDisplay = PokemonDisplay(name: name,
                                            sprite: pokemonData?.sprites.front_default ?? "",
                                            stats: pokemonStats,
                                            type: pokeTypes)
        
        return pokemonDisplay
    }
    
    func fetchPokemons() -> [Pokemon] {
        return coreDataManager.fetchPokemons()
    }

    func addPokemon(name: String, url: String) {
        coreDataManager.addPokemon(name: name, url: url)
    }
    
    func addPokemons(_ pokemons: [Pokemon]) {
        coreDataManager.addPokemons(pokemons: pokemons)
    }

    func removePokemon(withName name: String) {
        coreDataManager.removePokemon(withName: name)
    }
}

