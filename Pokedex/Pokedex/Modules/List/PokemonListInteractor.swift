//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import PokedexDataKit

class PokemonListInteractor: Interactor<PokemonListViewProperties, PokemonListViewPresenter> {
	
	// MARK: - Variables
	private let pokemonWorker = PokemonWorker()
	
	func refresh() {
#warning("Start loader")
		
		Task {
			do {
				var result: [Pokemon] = []
				
				for i in 1...151 {
					let response = try await self.pokemonWorker.fetch(id: i)
					result.append(response)
				}
				
				self.presenter.display(pokemons: result)
			} catch {
#warning("Log error")
				self.presenter.display(pokemons: [])
			}
			
			self.presenter.display()
#warning("Stop loader")
		}
	}
}
