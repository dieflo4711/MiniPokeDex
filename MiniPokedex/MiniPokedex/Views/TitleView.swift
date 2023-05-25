//
//  TitleView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-25.
//

import SwiftUI

struct TitleView: View {
    let name: String
    var body: some View {
        Text(name.capitalized)
            .font(.title)
            .foregroundColor(.blue)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(name: "Pikachu")
    }
}
