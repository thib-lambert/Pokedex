//
//  Pokemon.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import Foundation

public struct Pokemon {
	
	// MARK: - Variables
	public let id: Int
	public let name: String
	public let types: [Types]
	
	// MARK: - Init
	init(from response: PokemonResponse) {
		self.id = response.id
		self.name = response.name
		self.types = response.types.compactMap { Types(rawValue: $0.type.name) }
	}
}
