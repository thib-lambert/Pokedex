//
//  PokemonRequest.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import Foundation
import ToolsboxSDK_Network

struct PokemonRequest: PokeAPIRequest {
	
	let id: Int
	
	var module: PokeAPIModule { .pokemon }
	var route: String { "\(self.id)" }
	var method: RequestMethodType { .get }
}
