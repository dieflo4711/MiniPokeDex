//
//  BookmarkListViewModel.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

class BookmarkListViewModel: ObservableObject {
    @Published var bookmarkedPokemon: [PokemonDetails]?
    
    func getBookmarkedPokemon() {
        bookmarkedPokemon = PokemonService.shared.fetchBookmarked()
    }
    
    func removeAllBookmarks() {
        PokemonService.shared.removeAllBookmarks()
        bookmarkedPokemon = []
    }
}
