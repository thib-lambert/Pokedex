//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 15/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit
import SDWebImageSwiftUI

struct PokemonCell: View {
	
	// MARK: - Variables
	private var pokemonTypeColor: Color
	let pokemon: Pokemon
	
	// MARK: - UI
	var body: some View {
		HStack(spacing: 0) {
			VStack(alignment: .leading, spacing: 4) {
				Text(String(format: "N°%03d", self.pokemon.id))
					.font(.system(size: 12, weight: .semibold))
					.foregroundStyle(.black.opacity(0.7))
				
				Text(LocalizedStringKey(self.pokemon.name))
					.font(.system(size: 21, weight: .semibold))
					.foregroundStyle(.black)
				
				self.types
			}
			.padding(.vertical, 12)
			.padding(.horizontal, 16)
			
			Spacer()
			
			self.pokemonImage
		}
		.background(self.pokemonTypeColor.opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 16))
	}
	
	private var types: some View {
		HStack(spacing: 4) {
			ForEach(self.pokemon.types, id: \.self) { type in
				TypeTagView(type: type)
			}
		}
	}
	
	private var pokemonImage: some View {
		ZStack {
			if let image = self.pokemon.mainType?.picto {
				Image(image)
					.renderingMode(.template)
					.resizable()
					.scaledToFit()
					.padding(.vertical, 8)
					.padding(.horizontal, 16)
					.foregroundStyle(
						LinearGradient(colors: [.white.opacity(0.1), .white],
									   startPoint: .bottomTrailing,
									   endPoint: .topLeading)
					)
			}
			
			WebImage(url: self.pokemon.image) {
				$0.image?.resizable()
			}
			.scaledToFit()
			.frame(width: 96, height: 96)
		}
		.frame(width: 128, height: 104)
		.background(self.pokemonTypeColor)
		.clipShape(RoundedRectangle(cornerRadius: 16))
	}
	
	// MARK: - Init
	init(pokemon: Pokemon) {
		self.pokemonTypeColor = pokemon.mainType?.associatedColor ?? .gray
		self.pokemon = pokemon
	}
}

#Preview {
	VStack {
		PokemonCell(pokemon: .previewBulbasaur)
		PokemonCell(pokemon: .previewPikachu)
		PokemonCell(pokemon: .previewCharizard)
	}
}
