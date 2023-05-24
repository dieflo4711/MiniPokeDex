//
//  StatsView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct StatsView: View {
    let stats: PokemonStats
    
    var body: some View {
        VStack(alignment: .leading) {
            let propertyPairs = [
                ("hp", stats.hp),
                ("attack", stats.attack),
                ("defense", stats.defense),
                ("specialAttack", stats.specialAttack),
                ("specialDefense", stats.specialDefense),
                ("speed", stats.speed)
            ]

            ForEach(0..<propertyPairs.count / 2, id: \.self) { index in
                HStack {
                    statItem(label: propertyPairs[index * 2])
                    Spacer()
                    statItem(label: propertyPairs[index * 2 + 1])
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func statItem(label: (String, Int)) -> some View {
        HStack {
            Text("\(label.0):")
                .bold()
                .foregroundColor(.blue)
            Text("\(label.1)")
                .foregroundColor(.gray)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        let stats = PokemonStats(hp: 100,
                                 attack: 50,
                                 defense: 40,
                                 specialAttack: 60,
                                 specialDefense: 50,
                                 speed: 90)
        
        StatsView(stats: stats)
    }
}
