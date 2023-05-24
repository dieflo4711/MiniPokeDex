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
        }
    }
    
    private var mainContentView: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                Text(pokemon.name.uppercased())
                    .font(.title)
                    .foregroundColor(.blue)
                
                pokemonImageView(with: pokemon.sprite)
                
                HStack {
                    ForEach(pokemon.type, id: \.self) { string in
                        Text(string)
                            .padding(8)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                statsView(with: pokemon.stats)
                
                buttonsView
                Spacer()
            } else {
                Text("Fetching Pokémon...")
                    .font(.title)
                    .padding()
            }
        }
    }
    
    private func pokemonImageView(with imageUrl: String) -> some View {
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
    
    private func statsView(with stats: PokemonStats) -> some View {
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
    
    var propertyNames: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
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
    
    private func pokemonTitle() -> String {
        if let pokemon = viewModel.pokemon {
            return pokemon.name.uppercased()
        }
        
        return ""
    }
}

struct ParentStartView_Previews: PreviewProvider {
    static var previews: some View {
        ParentStartView()
    }
}


