//
//  PokemonDisplay.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import Foundation

struct PokemonDisplay: Decodable, Hashable {
    let name: String
    let sprite: String
    let stats: PokemonStats
    let type: [String]
}

struct PokemonStats: Decodable, Hashable {
    var hp: Int
    var attack: Int
    var defense: Int
    var specialAttack: Int
    var specialDefense: Int
    var speed: Int
}
