//
//  ContentView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import SwiftUI

struct PokemonListView: View {
	
	// MARK: - Variables
	private let interactor = PokemonListInteractor()
	@ObservedObject private var viewProperties = PokemonListViewProperties()
	
	// MARK: - UI
	var body: some View {
		ZStack(alignment: .bottom) {
			ScrollView(showsIndicators: false) {
				LazyVStack {
					ForEach(self.viewProperties.pokemons, id: \.id) { pokemon in
						NavigationLink(destination: PokemonDetailsView(pokemon: pokemon),
									   label: {
							PokemonCell(pokemon: pokemon)
								.padding(.bottom, 12)
								.padding(.horizontal, 16)
						})
					}
				}
				.padding(.bottom, 64)
			}
			
			Button(action: {
				self.interactor.openScan()
			}, label: {
				Image(systemName: "camera.viewfinder")
					.renderingMode(.template)
					.resizable()
					.scaledToFit()
					.padding(12)
					.foregroundStyle(.white)
					.frame(width: 60, height: 60)
					.background(Color.red)
					.clipShape(Circle())
			})
		}
		.setup(with: self.interactor, and: self.viewProperties)
		.fullScreenCover(isPresented: self.$viewProperties.canOpenScan) {
			PokemonScanView()
		}
	}
	
	// MARK: - Init
	init() {
		self.interactor.refresh()
	}
}

#Preview {
	PokemonListView()
}
