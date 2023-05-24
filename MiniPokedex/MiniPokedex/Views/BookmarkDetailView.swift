//
//  BookmarkDetailView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct BookmarkDetailView: View {
    @StateObject private var viewModel = BookmarkDetailViewModel()
    @State private var sheetHeight: CGFloat = .zero
    @Binding var isShowingDetail: Bool
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            headerButtons
            
            Text(pokemon.name.capitalized)
                .font(.title)
            
            imageView
        }
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            sheetHeight = newHeight
        }
        .presentationDetents([.height(sheetHeight)])
        .onAppear {
            viewModel.prepareViewModel(pokemon)
        }
    }
    
    private var headerButtons: some View {
        HStack {
            Button(action: {
                toggleBookmark()
            }) {
                Image(systemName: viewModel.bookmarked ? "bookmark.fill" : "bookmark")
                    .font(.title)
                    .padding()
                    .foregroundColor(.blue)
            }
            Spacer()
            Button(action: {
                closeSheet()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
    
    private var imageView: some View {
        AsyncImage(url: URL(string: pokemon.url)) { phase in
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
    
    private func toggleBookmark() {
        if viewModel.bookmarked {
            viewModel.removeBookmark(pokemon)
        } else {
            viewModel.addBookmark(pokemon)
        }
    }
    
    private func closeSheet() {
        isShowingDetail = false
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct BookmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = Pokemon(name: "Pikachu", url: "pikachu_sprite_url")
        return BookmarkDetailView(isShowingDetail: .constant(true), pokemon: pokemon)
    }
}
