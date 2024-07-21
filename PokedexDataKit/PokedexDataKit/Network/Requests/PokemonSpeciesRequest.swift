//
//  PokemonSpeciesRequest.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 21/07/2024.
//

import Foundation
import ToolsboxSDK_Network

struct PokemonSpeciesRequest: PokeAPIRequest {
	
	let id: Int
	
	var module: PokeAPIModule { .species }
	var route: String { "\(self.id)" }
	var method: RequestMethodType { .get }
	
	var cacheKey: RequestCacheKey? {
		RequestCacheKey(key: "species_\(self.id)",
						type: .returnCacheDataElseLoad,
						days: 10)
	}
}
