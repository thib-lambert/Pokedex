//
//  PokeAPIRequest.swift
//  PokedexDataKit
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import Foundation
import ToolsboxSDK_Network

enum PokeAPIModule: String {
	
	case pokemon
	case species = "pokemon-species"
}

protocol PokeAPIRequest: RequestProtocol {
	
	var route: String { get }
	var module: PokeAPIModule { get }
}

extension PokeAPIRequest {
	
	var scheme: String { "https" }
	var host: String { "pokeapi.co" }
	var path: String { "/api/v2/\(self.module.rawValue)/\(self.route)" }
}
