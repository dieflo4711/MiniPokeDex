//
//  PokemonDetails.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import Foundation

struct PokemonDetails: Decodable, Encodable, Hashable {
    let name: String
    let image: String
    let stats: PokemonStats
    let type: [String]
}

struct PokemonStats: Decodable, Encodable, Hashable {
    var hp: Int
    var attack: Int
    var defense: Int
    var specialAttack: Int
    var specialDefense: Int
    var speed: Int
}
