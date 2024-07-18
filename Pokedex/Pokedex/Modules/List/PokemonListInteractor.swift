//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import PokedexDataKit
import os

class PokemonListInteractor: Interactor<PokemonListViewProperties, PokemonListPresenter> {
	
	// MARK: - Variables
	private let pokemonWorker = PokemonWorker()
	private let cameraManager = CameraManager()
	private lazy var logger = Logger(subsystem: "\(Self.self)")
	
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
				self.logger.fault("\(error.localizedDescription)")
				self.presenter.update(pokemons: [])
			}
			
#warning("Stop loader")
		}
	}
	
	func openScan() {
		Task {
			do {
				try await self.cameraManager.setup()
				self.presenter.update(canShowScan: true)
			} catch CameraManager.Error.needToBeAuthorize {
				#warning("Redirect to settings")
			} catch {
				self.logger.fault("\(error.localizedDescription)")
				self.presenter.update(canShowScan: false)
			}
		}
	}
}
