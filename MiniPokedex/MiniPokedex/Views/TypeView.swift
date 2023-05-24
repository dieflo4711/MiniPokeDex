//
//  TypeView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct TypeView: View {
    let type: [String]
    
    var body: some View {
        HStack {
            ForEach(type, id: \.self) { string in
                Text(string)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(type: ["grass"])
    }
}
