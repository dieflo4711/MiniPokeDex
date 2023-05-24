//
//  ParentStartView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct ParentStartView: View {
    @StateObject private var viewModel = ParentStartViewModel()
    @State private var isMenuOpen = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    headerView
                    .frame(width: geometry.size.width, alignment: .leading)
                    .background(.blue)
                    
                    mainContentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: isMenuOpen ? geometry.size.width / 2 : 0)
                .overlay(
                    ZStack {
                        if isMenuOpen {
                            Color.black.opacity(0.5)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    isMenuOpen = false
                                }
                        }
                    }
                )
                
                if isMenuOpen {
                    SideMenuView()
                        .frame(width: geometry.size.width / 2)
                        .transition(.move(edge: .leading))
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                Task {
                    await viewModel.getPokemon()
                }
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                isMenuOpen.toggle()
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.title)
                    .padding()
                    .foregroundColor(isMenuOpen ? .white.opacity(0.5) : .white)
            }
            .padding(.trailing)
            Spacer()
            Button(action: {
                viewModel.toggleBookmark()
            }) {
                Image(systemName: viewModel.bookmarked ? "bookmark.fill" : "bookmark")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
            }
        }
    }
    
    private var mainContentView: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                Text(pokemon.name.uppercased())
                    .font(.title)
                    .foregroundColor(.blue)
                
                imageView(with: pokemon.sprite)
                
                TypeView(type: pokemon.type)
                
                StatsView(stats: pokemon.stats)
                
                buttonsView
                Spacer()
            } else {
                Text("Fetching Pokémon...")
                    .font(.title)
                    .padding()
            }
        }
    }
    
    private func imageView(with imageUrl: String) -> some View {
        let pokemonImageURL = URL(string: imageUrl)
        return ZStack(alignment: .topTrailing) {
            AsyncImage(url: pokemonImageURL) { phase in
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
    
    private var buttonsView: some View {
        Button(action: {
            Task {
                await viewModel.getPokemon()
            }
        }) {
            Text("Change")
                .font(.title3)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct ParentStartView_Previews: PreviewProvider {
    static var previews: some View {
        ParentStartView()
    }
}


