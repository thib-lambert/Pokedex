//
//  PokemonScanViewProperties.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import UIKit
import CoreGraphics

class PokemonScanViewProperties: ViewProperties {
	
	// MARK: - Variables
	@Published var pokemon: String?
	@Published var image: CGImage?
	
	// MARK: - Init
	required init() {
		self.pokemon = nil
		self.image = nil
	}
}
