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
		let response = try await PokemonRequest(id: id).response(PokemonResponse.self)
		return Pokemon(from: response)
	}
}
