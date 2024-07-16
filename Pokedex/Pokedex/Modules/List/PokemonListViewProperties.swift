//
//  PokemonListViewProperties.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import PokedexDataKit

class PokemonListViewProperties: ViewProperties {
	
	@Published var pokemons: [Pokemon] = []
	@Published var canOpenScan = false
}
