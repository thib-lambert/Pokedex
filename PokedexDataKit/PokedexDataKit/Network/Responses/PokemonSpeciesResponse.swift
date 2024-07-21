//
//  PokemonSpeciesResponse.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 21/07/2024.
//

import Foundation

struct PokemonSpeciesResponse: Decodable {
	
	enum CodingKeys: String, CodingKey {
		case flavorTextEntries = "flavor_text_entries"
		case names
	}
	
	let flavorTextEntries: [FlavorTextEntry]
	let names: [Name]
}

// MARK: - FlavorTextEntry
extension PokemonSpeciesResponse {
	
	struct FlavorTextEntry: Decodable {
		
		enum CodingKeys: String, CodingKey {
			case flavorText = "flavor_text"
			case language
		}
		
		let flavorText: String
		let language: Language
	}
}

// MARK: - Language
extension PokemonSpeciesResponse {
	
	struct Language: Decodable {
		
		let name: String
	}
}

// MARK: - Name
extension PokemonSpeciesResponse {
	
	struct Name: Decodable {
		
		let language: Language
		let name: String
	}
}
