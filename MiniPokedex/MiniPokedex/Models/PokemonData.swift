//
//  PokemonData.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import Foundation

struct PokemonData: Codable {
    var sprites: PokemonSprites
    var stats: [Stats]
    var types: [Types]
}

struct PokemonSprites: Codable {
    var front_default: String
}

struct Stats: Codable {
    var base_stat: Int
    var stat: Stat
}

struct Stat: Codable {
    var name: String
}

struct Types: Codable {
    var type: PokeType
}

struct PokeType: Codable {
    var name: String
}
