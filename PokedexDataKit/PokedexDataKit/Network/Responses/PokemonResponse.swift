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
	let height: Double
	let weight: Double
}

// MARK: - Sprites
extension PokemonResponse {
	
	struct Sprites: Decodable {
		
		// MARK: - Other
		struct Other: Decodable {
			
			// MARK: - OfficialArtwork
			struct OfficialArtwork: Decodable {
				
				enum CodingKeys: String, CodingKey {
					
					case frontDefault = "front_default"
				}
				
				let frontDefault: String
			}
			
			enum CodingKeys: String, CodingKey {
				
				case officialArtwork = "official-artwork"
			}
			
			let officialArtwork: OfficialArtwork
		}
		
		let other: Other
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
