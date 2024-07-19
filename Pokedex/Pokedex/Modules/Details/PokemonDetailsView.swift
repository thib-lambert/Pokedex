//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 17/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit

struct PokemonDetailsView: View {
	
	// MARK: - Variables
	private let interactor = PokemonDetailsInteractor()
	@ObservedObject private var viewProperties = PokemonDetailsViewProperties()
	
	private var pokemonTypeColor: Color
	let pokemon: Pokemon
	
	// MARK: - Body
	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				self.header
				
				VStack(spacing: 20) {
					self.nameAndId
					self.types
					
					Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar at dui ac rutrum. Duis blandit cursus tortor, et dapibus nibh pretium a. Sed tincidunt scelerisque quam sed porta. Maecenas efficitur felis sit amet dolor elementum tempor. Curabitur non fringilla orci, ac ultrices enim. Aenean eu augue volutpat, malesuada nulla vel, dignissim nisl. Vivamus ut tellus est. Suspendisse sagittis vitae magna vel convallis. Mauris quis porttitor risus. Integer convallis laoreet congue.")
						.font(.system(size: 14, weight: .regular))
						.frame(maxWidth: .infinity, alignment: .leading)
						.foregroundStyle(.black.opacity(0.7))
					
					self.informations
				}
				.padding(.horizontal, 16)
			}
		}
		.scrollBounceBehavior(.basedOnSize)
		.setup(with: self.interactor, and: self.viewProperties)
	}
	
	private var header: some View {
		GeometryReader { geo in
			ZStack(alignment: .bottom) {
				Circle()
					.fill(LinearGradient(colors: [self.pokemonTypeColor.opacity(0.1), self.pokemonTypeColor],
										 startPoint: .bottomTrailing,
										 endPoint: .topLeading))
					.scaleEffect(2)
					.offset(CGSize(width: 0, height: -geo.size.height / 1.5))
					.frame(maxWidth: .infinity)
				
				if let type = self.pokemon.mainType {
					Image(type.picto)
						.renderingMode(.template)
						.resizable()
						.scaledToFit()
						.padding(.bottom, 80)
						.foregroundStyle(LinearGradient(colors: [.white.opacity(0.1), .white],
														startPoint: .bottomTrailing,
														endPoint: .topLeading))
				}
				
				AsyncImage(url: self.pokemon.image) {
					$0.image?.resizable()
				}
				.scaledToFit()
				.frame(width: geo.size.width - (24 * 2),
					   height: geo.size.height - 40)
				.padding(.bottom, -24)
			}
		}
		.frame(height: 300)
	}
	
	private var nameAndId: some View {
		VStack(spacing: 0) {
			Text(LocalizedStringKey(self.pokemon.name))
				.font(.system(size: 32, weight: .medium))
				.frame(maxWidth: .infinity, alignment: .leading)
			
			Text(String(format: "N°%03d", self.pokemon.id))
				.font(.system(size: 16, weight: .medium))
				.frame(maxWidth: .infinity, alignment: .leading)
				.foregroundStyle(.black.opacity(0.7))
		}
	}
	
	private var types: some View {
		HStack(spacing: 4) {
			ForEach(self.pokemon.types, id: \.self) { type in
				TypeTagView(type: type, fontSize: 14)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var informations: some View {
		HStack(spacing: 20) {
			self.informations(with: self.pokemon.weight.toWeight(maximumFractionDigits: 1),
							  picto: .informationsWeight,
							  title: "pokemon_details_weight_title")
			
			self.informations(with:  self.pokemon.height.toDistance(maximumFractionDigits: 1),
							  picto: .informationsHeight,
							  title: "pokemon_details_height_title")
		}
	}
	
	// MARK: - Helpers
	private func informations(with value: String,
							  picto: ImageResource,
							  title: LocalizedStringResource) -> some View {
		VStack(alignment: .leading, spacing: 4) {
			HStack(spacing: 4) {
				Image(picto)
					.resizable()
					.scaledToFit()
					.frame(width: 16, height: 16)
				
				Text(title)
					.lineLimit(1)
					.font(.system(size: 12, weight: .medium))
					.foregroundStyle(.black.opacity(0.6))
			}
			
			Text(value)
				.lineLimit(1)
				.font(.system(size: 18, weight: .medium))
				.foregroundStyle(.black.opacity(0.9))
				.padding(.vertical, 8)
				.padding(.horizontal, 12)
				.frame(maxWidth: .infinity)
				.overlay(
					RoundedRectangle(cornerRadius: 16)
						.stroke(.black.opacity(0.1), lineWidth: 1)
				)
		}
	}
	
	// MARK: - Init
	init(pokemon: Pokemon) {
		self.pokemon = pokemon
		self.pokemonTypeColor = pokemon.mainType?.associatedColor ?? .gray
	}
}

#Preview("Charizard") {
	PokemonDetailsView(pokemon: .previewCharizard)
}

#Preview("Pikachu") {
	PokemonDetailsView(pokemon: .previewPikachu)
}

#Preview("Bulbasaur") {
	PokemonDetailsView(pokemon: .previewBulbasaur)
}
