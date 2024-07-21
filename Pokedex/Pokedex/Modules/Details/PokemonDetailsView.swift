//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 17/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit
import SDWebImageSwiftUI

private let kHeaderHeight: CGFloat = 300

struct PokemonDetailsView: View {
	
	// MARK: - Variables
	private let interactor = PokemonDetailsInteractor()
	@ObservedObject private var viewProperties = PokemonDetailsViewProperties()
	private var pokemonTypeColor: Color
	@State private var offset: CGFloat = .zero
	
	let pokemon: Pokemon
	
	// MARK: - Body
	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				self.header
					.frame(height: kHeaderHeight)
				
				VStack(spacing: 20) {
					self.nameAndId
					self.types
					self.description
					self.informations
				}
				.padding(.horizontal, 16)
			}
			.background(GeometryReader {
				Color.clear.preference(key: ViewOffsetKey.self,
									   value: -$0.frame(in: .named("scroll")).origin.y)
			}).onPreferenceChange(ViewOffsetKey.self) { self.offset = $0 }
		}
		.coordinateSpace(name: "scroll")
		.scrollBounceBehavior(.basedOnSize)
		.toolbar {
			if self.offset >= kHeaderHeight {
				ToolbarItem(placement: .principal) {
					WebImage(url: self.pokemon.image) {
						$0.image?.resizable()
					}
					.scaledToFit()
					.padding(.vertical, 4)
				}
			}
		}
		.setup(with: self.interactor, and: self.viewProperties)
	}
	
	private var header: some View {
		ZStack {
			Rectangle()
				.frame(height: 0)
			
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
			
			WebImage(url: self.pokemon.image) {
				$0.image?.resizable()
			}
			.scaledToFit()
			.padding(.horizontal, 24)
		}
		.background(
			GeometryReader { geo in
				UnevenRoundedRectangle(bottomLeadingRadius: geo.size.width,
									   bottomTrailingRadius: geo.size.width)
				.fill(LinearGradient(colors: [
					self.pokemonTypeColor.opacity(0.5),
					self.pokemonTypeColor
				],
									 startPoint: .bottomTrailing,
									 endPoint: .topLeading))
				.frame(height: UIScreen.main.bounds.height * 2)
				.offset(x: -24,
						y: (geo.size.height - 48) - (UIScreen.main.bounds.height * 2))
				.frame(width: geo.size.width + 48)
				
			})
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
	
	private var description: some View {
		Text(self.pokemon.description)
				.font(.system(size: 14, weight: .regular))
				.frame(maxWidth: .infinity, alignment: .leading)
				.foregroundStyle(.black.opacity(0.7))
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

// MARK: - ViewOffsetKey
private struct ViewOffsetKey: PreferenceKey {
	static var defaultValue: CGFloat = .zero
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value += nextValue()
	}
}

// MARK: - Previews
#Preview("Charizard") {
	NavigationStack {
		PokemonDetailsView(pokemon: .previewCharizard)
	}
}

#Preview("Pikachu") {
	NavigationStack {
		PokemonDetailsView(pokemon: .previewPikachu)
	}
}

#Preview("Bulbasaur") {
	NavigationStack {
		PokemonDetailsView(pokemon: .previewBulbasaur)
	}
}
