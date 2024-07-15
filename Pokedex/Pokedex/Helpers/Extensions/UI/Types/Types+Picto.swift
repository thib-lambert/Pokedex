//
//  Types+Picto.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 15/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit

extension Types {
	
	var picto: ImageResource {
		switch self {
		case .bug: return .typesBug
		case .dark: return .typesDark
		case .dragon: return .typesDragon
		case .electric: return .typesElectric
		case .fairy: return .typesFairy
		case .fighting: return .typesFighting
		case .fire: return .typesFire
		case .flying: return .typesFlying
		case .ghost: return .typesGhost
		case .grass: return .typesGrass
		case .ground: return .typesGround
		case .ice: return .typesIce
		case .normal: return .typesNormal
		case .poison: return .typesPoison
		case .psychic: return .typesPsychic
		case .rock: return .typesRock
		case .steel: return .typesSteel
		case .water: return .typesWater
		}
	}
}
