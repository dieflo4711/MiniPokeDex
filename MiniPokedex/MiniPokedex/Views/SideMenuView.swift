//
//  SideMenuView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pokedex")
                .bold()
                .font(.title)
            
            NavigationLink(destination: BookmarkListView()) {
                IconTextRow(systemName: "bookmark", text: "Bookmarked")
                    .foregroundColor(.blue)
            }
            IconTextRow(systemName: "checkmark.circle", text: "Selected")
                .foregroundColor(.blue)
            Spacer()
        }
        .padding(.top, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
            Text(text)
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
