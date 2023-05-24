//
//  Pokemon.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import Foundation

struct Pokemon: Decodable, Encodable, Hashable {
    let name: String
    let url: String
}
