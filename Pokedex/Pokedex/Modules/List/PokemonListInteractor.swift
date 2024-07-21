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
		Task {
			let data = await withTaskGroup(of: Pokemon?.self) { group in
				for id in 1...151 {
					group.addTask {
						try? await self.loadPokemon(id: id)
					}
				}
				
				return await group.reduce(into: [Pokemon]()) { partialResult, pokemon in
					partialResult.append(pokemon)
				}
			}
				.compactMap { $0 }
				.sorted { $0.order < $1.order }
			
			self.presenter.update(pokemons: data)
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
	
	private func loadPokemon(id: Int) async throws -> Pokemon {
		do {
			return try await self.pokemonWorker.fetch(id: id)
		} catch {
			self.logger.fault("Failed to load Pokemon \(id): \(error.localizedDescription)")
			throw error
		}
	}
}
