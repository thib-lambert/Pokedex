//
//  Pokemon.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import Foundation
import ToolsboxSDK_Helpers

public struct Pokemon {
	
	// MARK: - Variables
	public let id: Int
	public let name: String
	public let types: [Types]
	public let image: URL?
	public let mainType: Types?
	public let height: Double
	public let weight: Double
	
	// MARK: - Init
	init(from response: PokemonResponse) {
		self.id = response.id
		self.name = response.name.lowercased()
		self.types = response.types.compactMap { Types(rawValue: $0.type.name.lowercased()) }
		self.image = URL(response.sprites.other.officialArtwork.frontDefault)
		self.mainType = self.types.first
		self.height = response.height / 10
		self.weight = response.weight / 10
	}
	
	fileprivate init(id: Int, name: String, types: [Types], image: URL?) {
		self.id = id
		self.name = name
		self.types = types
		self.image = image
		self.mainType = types.first
		self.height = 20
		self.weight = 10
	}
}

// MARK: - Previews
public extension Pokemon {
	
	static let previewBulbasaur = Pokemon(id: 1,
										  name: "bulbasaur",
										  types: [.grass, .poison],
										  image: URL("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))
	
	static let previewPikachu = Pokemon(id: 25,
										name: "pikachu",
										types: [.electric],
										image: URL("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"))
	
	static let previewCharizard = Pokemon(id: 6,
										  name: "charizard",
										  types: [.fire, .flying],
										  image: URL("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png"))
}
