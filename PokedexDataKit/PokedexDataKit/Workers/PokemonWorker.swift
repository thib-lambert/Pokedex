//
//  PokemonWorker.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import Foundation

public struct PokemonWorker {
	
	// MARK: - Init
	public init() { }
	
	public func fetch(id: Int) async throws -> Pokemon {
		let pokemon = try await PokemonRequest(id: id).response(PokemonResponse.self)
		let species = try await PokemonSpeciesRequest(id: id).response(PokemonSpeciesResponse.self)
		
		return Pokemon(with: pokemon, and: species)
	}
}
