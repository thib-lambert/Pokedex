//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 15/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit

struct PokemonCell: View {
	
	// MARK: - Variables
	let pokemon: Pokemon
	
	// MARK: - UI
	var body: some View {
		HStack(spacing: 0) {
			VStack(alignment: .leading, spacing: 4) {
				Text(String(format: "N°%03d", self.pokemon.id))
					.font(.system(size: 12, weight: .semibold))
				
				Text(LocalizedStringKey(self.pokemon.name))
					.font(.system(size: 21, weight: .semibold))
				
				self.types
			}
			.padding(.vertical, 12)
			.padding(.horizontal, 16)
			
			Spacer()
			
			self.pokemonImage
		}
		.background((self.pokemon.mainType?.associatedColor ?? .gray).opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 16))
	}
	
	private var types: some View {
		HStack(spacing: 4) {
			ForEach(self.pokemon.types, id: \.self) { type in
				HStack(spacing: 4) {
					Image(type.picto)
						.resizable()
						.scaledToFit()
						.padding(4)
						.frame(width: 20, height: 20)
						.background(Color.white)
						.clipShape(Circle())
					
					Text(LocalizedStringKey(type.rawValue.lowercased()))
						.font(.system(size: 11, weight: .medium))
						.padding(.trailing, 4)
				}
				.padding(4)
				.background(type.associatedColor)
				.clipShape(Capsule())
			}
		}
	}
	
	private var pokemonImage: some View {
		ZStack {
			Group {
				if let image = self.pokemon.mainType?.picto {
					Image(image)
						.renderingMode(.template)
						.resizable()
						.scaledToFit()
				}
			}
			.padding(.vertical, 8)
			.padding(.horizontal, 16)
			.foregroundStyle(
				LinearGradient(colors: [.white.opacity(0.1), .white],
							   startPoint: .bottomTrailing,
							   endPoint: .topLeading)
			)
			
			AsyncImage(url: self.pokemon.image)
				.scaledToFit()
				.frame(width: 96, height: 96)
		}
		.frame(width: 128, height: 104)
		.background(self.pokemon.mainType?.associatedColor ?? .gray)
		.clipShape(RoundedRectangle(cornerRadius: 16))
	}
}

#Preview {
	VStack {
		PokemonCell(pokemon: .previewBulbasaur)
		PokemonCell(pokemon: .previewPikachu)
	}
}
