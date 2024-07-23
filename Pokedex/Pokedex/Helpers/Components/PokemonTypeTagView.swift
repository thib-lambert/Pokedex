//
//  PokemonTypeTagView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 17/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit

struct PokemonTypeTagView: View {
	
	// MARK: - Variables
	let type: PokemonType
	let fontSize: CGFloat
	
	// MARK: - Body
	var body: some View {
		HStack(spacing: 4) {
			Image(self.type.picto)
				.resizable()
				.scaledToFit()
				.frame(width: 16, height: 16)
				.padding(4)
				.background(Color.white)
				.clipShape(Circle())
			
			Text(LocalizedStringKey(self.type.rawValue.lowercased()))
				.font(.system(size: self.fontSize, weight: .medium))
				.foregroundStyle(.black)
				.padding(.trailing, 4)
		}
		.padding(4)
		.background(self.type.associatedColor)
		.clipShape(Capsule())
	}
	
	// MARK: - Init
	init(type: PokemonType, fontSize: CGFloat = 11) {
		self.type = type
		self.fontSize = fontSize
	}
}

#Preview {
	PokemonTypeTagView(type: .fire, fontSize: 14)
}
