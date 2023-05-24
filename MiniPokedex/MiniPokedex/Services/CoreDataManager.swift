//
//  CoreDataManager.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import Foundation
import CoreData

class PokemonEntity: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var url: String
}

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokemons")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Core Data error \(error), \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private init() {}
    
    private func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPokemons() -> [Pokemon] {
        let fetchRequest: NSFetchRequest<PokemonEnt> = PokemonEnt.fetchRequest()

        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(fetchRequest)

            let pokemonArray = fetchedEntities.map { pokemonEntity -> Pokemon in
                return Pokemon(name: pokemonEntity.name ?? "Unknown", url: pokemonEntity.url ?? "Unknown")
            }

            return pokemonArray
        } catch {
            fatalError("Failed to fetch Pokemon entities: \(error)")
        }
    }

    func addPokemon(name: String, url: String) {
        let pokemon = PokemonEnt(context: persistentContainer.viewContext)
        pokemon.name = name
        pokemon.url = url

        saveContext()
    }
    
    func removePokemon(withName name: String) {
        let viewContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PokemonEnt> = PokemonEnt.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let fetchedEntities = try viewContext.fetch(fetchRequest)
            fetchedEntities.forEach(viewContext.delete)
            saveContext()
        } catch {
            fatalError("Failed to fetch and delete Pokemon entities: \(error)")
        }
    }
    
    func addPokemons(pokemons: [Pokemon]) {
        let dictionaries = pokemons.map { myStruct -> [String: Any] in
            return [
                "name": myStruct.name,
                "url": myStruct.url
            ]
        }

        let insertRequest = NSBatchInsertRequest(entity: PokemonEnt.entity(), objects: dictionaries)
        insertRequest.resultType = .statusOnly

        do {
            try persistentContainer.viewContext.execute(insertRequest)
            saveContext()
        } catch {
            print("Failed to save fetched Pokémon to Core Data: \(error)")
        }
    }
    
    func deleteAllPokemons() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PokemonEnt.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
           try persistentContainer.viewContext.execute(deleteRequest)
           saveContext()
        } catch {
           print("Failed to delete entities: \(error)")
        }
    }
    
    func removeBookmark(withName name: String) {
        let viewContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<BookmarkedEnt> = BookmarkedEnt.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let fetchedEntities = try viewContext.fetch(fetchRequest)
            fetchedEntities.forEach(viewContext.delete)
            saveContext()
        } catch {
            fatalError("Failed to fetch and delete Pokemon entities: \(error)")
        }
    }
    
    func removeBookmarks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = BookmarkedEnt.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
           try persistentContainer.viewContext.execute(deleteRequest)
           saveContext()
        } catch {
           print("Failed to delete entities: \(error)")
        }
    }

    func isBookmarked(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<BookmarkedEnt> = BookmarkedEnt.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        if let result = try? persistentContainer.viewContext.fetch(fetchRequest), !result.isEmpty {
            return true
        }

        return false
    }
    
    func fetchBookmarked() -> [Pokemon] {
        let fetchRequest: NSFetchRequest<BookmarkedEnt> = BookmarkedEnt.fetchRequest()

        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(fetchRequest)

            let pokemonArray = fetchedEntities.map { pokemonEntity -> Pokemon in
                return Pokemon(name: pokemonEntity.name ?? "Unknown", url: pokemonEntity.url ?? "Unknown")
            }

            return pokemonArray
        } catch {
            fatalError("Failed to fetch Pokemon entities: \(error)")
        }
    }
    
    func fetchBookmarkedPokemons() -> [Pokemon] {
        let fetchRequest: NSFetchRequest<BookmarkedEnt> = BookmarkedEnt.fetchRequest()

        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(fetchRequest)

            let pokemonArray = fetchedEntities.map { pokemonEntity -> Pokemon in
                return Pokemon(name: pokemonEntity.name ?? "Unknown", url: pokemonEntity.url ?? "Unknown")
            }

            return pokemonArray
        } catch {
            fatalError("Failed to fetch Pokemon entities: \(error)")
        }
    }
    
    func bookmarkPokemon(name: String, url: String) {
        let pokemon = BookmarkedEnt(context: persistentContainer.viewContext)
        pokemon.name = name
        pokemon.url = url

        saveContext()
    }
}

