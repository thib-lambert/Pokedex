//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import PokedexDataKit

class PokemonListInteractor: Interactor<PokemonListViewProperties, PokemonListPresenter> {
	
	// MARK: - Variables
	private let pokemonWorker = PokemonWorker()
	private let cameraManager = CameraManager()
	
	func refresh() {
#warning("Start loader")
		
		Task {
			do {
				var result: [Pokemon] = []
				
				for i in 1...151 {
					let response = try await self.pokemonWorker.fetch(id: i)
					result.append(response)
				}
				
				self.presenter.update(pokemons: result)
			} catch {
#warning("Log error")
				self.presenter.update(pokemons: [])
			}
			
#warning("Stop loader")
		}
	}
	
	func openScan() {
		Task {
			let isAuthorized = await self.cameraManager.isAuthorized
			self.presenter.update(canShowScan: isAuthorized)
			self.presenter.display()
		}
	}
}
