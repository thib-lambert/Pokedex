//
//  PokemonScanPresenter.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import CoreImage

class PokemonScanPresenter: Presenter<PokemonScanViewProperties> {
	
	func update(pokemon: String?) {
		Task { @MainActor in
			self.viewProperties.pokemon = pokemon
		}
	}
	
	func update(_ image: CGImage?) {
		Task { @MainActor in
			self.viewProperties.image = image
		}
	}
}
