//
//  RandomPokemonButtonView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

struct RandomPokemonButtonView: View {
    var getPokemon: () -> Void
    var useInfinityMaxWidth: Bool = false
    
    var body: some View {
        Button(action: {
            Task {
                getPokemon()
            }
        }) {
            Text("Next")
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: useInfinityMaxWidth ? .infinity : .none)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct RandomPokemonButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RandomPokemonButtonView(getPokemon: {}, useInfinityMaxWidth: false)
    }
}
