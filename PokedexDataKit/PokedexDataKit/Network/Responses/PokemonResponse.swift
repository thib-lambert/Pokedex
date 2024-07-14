//
//  PokemonResponse.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import Foundation

struct PokemonResponse: Decodable {
	
	let id: Int
	let name: String
	let sprites: Sprites
	let types: [Types]
}

// MARK: - Sprites
extension PokemonResponse {
	
	struct Sprites: Decodable {
		
		enum CodingKeys: String, CodingKey {
			
			case frontDefault = "front_default"
		}
		
		let frontDefault: String
	}
}

// MARK: - Types
extension PokemonResponse {
	
	struct Types: Decodable {
		
		struct `Type`: Decodable {
		
			let name: String
		}
		
		let type: `Type`
	}
}
