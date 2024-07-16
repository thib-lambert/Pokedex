//
//  PokemonListViewPresenter.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import PokedexDataKit

class PokemonListViewPresenter: Presenter<PokemonListViewProperties> {
	
	func display(pokemons: [Pokemon]) {
		self.viewProperties.pokemons = pokemons
	}
}
