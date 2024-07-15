//
//  Types+Color.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 15/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit

extension Types {
	
	var associatedColor: Color {
		switch self {
		case .bug: return .green91C12F
		case .dark: return .grey5A5465
		case .dragon: return .blue0B6DC3
		case .electric: return .yellowF4D23C
		case .fairy: return .pinkEC8FE6
		case .fighting: return .pinkCE416B
		case .fire: return .orangeFF9D55
		case .flying: return .blue89AAE3
		case .ghost: return .blue5269AD
		case .grass: return .green63BC5A
		case .ground: return .brownD97845
		case .ice: return .green73CEC0
		case .normal: return .grey919AA2
		case .poison: return .purpleB567CE
		case .psychic: return .pinkFA7179
		case .rock: return .brownC5B78C
		case .steel: return .blue5A8EA2
		case .water: return .blue5090D6
		}
	}
}
