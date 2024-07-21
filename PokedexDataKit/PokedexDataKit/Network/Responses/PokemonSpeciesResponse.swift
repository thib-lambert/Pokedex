//
//  PokemonSpeciesResponse.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 21/07/2024.
//

import Foundation

struct PokemonSpeciesResponse: Decodable {
	
	// MARK: - FlavorTextEntry
	struct FlavorTextEntry: Decodable {
		
		// MARK: - Language
		struct Language: Decodable {
			
			let name: String
		}
		
		enum CodingKeys: String, CodingKey {
			case flavorText = "flavor_text"
			case language
		}
		
		let flavorText: String
		let language: Language
	}
	
	enum CodingKeys: String, CodingKey {
		case flavorTextEntries = "flavor_text_entries"
	}
	
	let flavorTextEntries: [FlavorTextEntry]
}
