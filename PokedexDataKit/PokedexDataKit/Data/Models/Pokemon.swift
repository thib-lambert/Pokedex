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
	public let nameKey: String
	public let name: String
	public let types: [Types]
	public let image: URL?
	public let mainType: Types?
	public let height: Double
	public let weight: Double
	public let description: String
	
	// MARK: - Init
	init(with pokemon: PokemonResponse, and species: PokemonSpeciesResponse) {
		self.id = pokemon.id
		self.nameKey = pokemon.name.lowercased()
		self.types = pokemon.types.compactMap { Types(rawValue: $0.type.name.lowercased()) }
		self.image = URL(pokemon.sprites.other.officialArtwork.frontDefault)
		self.height = pokemon.height / 10
		self.weight = pokemon.weight / 10
		
		self.name = species.names.first { Locale.current.identifier.starts(with: $0.language.name.lowercased()) }?
			.name
		?? species.names.first { _ in Locale.current.identifier.starts(with: "en") }?
			.name
		?? pokemon.name.lowercased()
		
		self.description = (species.flavorTextEntries
			.first { Locale.current.identifier.starts(with: $0.language.name.lowercased()) }?
			.flavorText
							?? species.flavorTextEntries.first { _ in Locale.current.identifier.starts(with: "en") }?
			.flavorText
		?? "")
		.replacingOccurrences(of: "\n", with: " ")
		self.mainType = self.types.first
	}
	
	fileprivate init(id: Int, name: String, types: [Types], image: URL?) {
		self.id = id
		self.nameKey = name
		self.name = name
		self.types = types
		self.image = image
		self.mainType = types.first
		self.height = 20
		self.weight = 10
		self.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar at dui ac rutrum. Duis blandit cursus tortor, et dapibus nibh pretium a. Sed tincidunt scelerisque quam sed porta. Maecenas efficitur felis sit amet dolor elementum tempor. Curabitur non fringilla orci, ac ultrices enim. Aenean eu augue volutpat, malesuada nulla vel, dignissim nisl. Vivamus ut tellus est. Suspendisse sagittis vitae magna vel convallis. Mauris quis porttitor risus. Integer convallis laoreet congue."
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
