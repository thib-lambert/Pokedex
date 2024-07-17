//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import SwiftUI

@main
struct PokedexApp: App {
	
	var body: some Scene {
		WindowGroup {
			NavigationStack {
				PokemonListView()
			}
		}
    }
}
