//
//  SelectedPokemonButtonView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

struct SelectedPokemonButtonView: View {
    var isSelected: Bool
    var toggleSelected: () -> Void
    var useInfinityMaxWidth: Bool = false
    
    var body: some View {
        Button(action: {
            toggleSelected()
        }) {
            Text(isSelected ? "Unselect" : "Select")
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: useInfinityMaxWidth ? .infinity : .none)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.black, lineWidth: 1)
                )
                .background(isSelected ? Color.blue : Color.clear)
                .foregroundColor(isSelected ? .white : Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct SelectedPokemonButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPokemonButtonView(isSelected: true, toggleSelected: {}, useInfinityMaxWidth: false)
    }
}
