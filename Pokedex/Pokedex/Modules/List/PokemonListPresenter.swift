//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import PokedexDataKit

class PokemonListPresenter: Presenter<PokemonListViewProperties> {
	
	func update(pokemons: [Pokemon]) {
		Task { @MainActor in
			self.viewProperties.pokemons = pokemons
		}
	}
	
	func update(canShowScan: Bool) {
		Task { @MainActor in
			self.viewProperties.canOpenScan = canShowScan
		}
	}
}
