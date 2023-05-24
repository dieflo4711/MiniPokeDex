//
//  ImageView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct ImageView: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280, height: 280)
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            @unknown default:
                Text("Unknown image loading state")
            }
        }
        .background(.thinMaterial)
        .clipShape(Circle())
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "")
    }
}
