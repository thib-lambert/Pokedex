//
//  ContentView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 14/07/2024.
//

import SwiftUI
import PokedexDataKit

struct ContentView: View {
	
	// MARK: - Variables
	@State var pokemons: [Pokemon] = []
	
	// MARK: - UI
	var body: some View {
		ZStack(alignment: .bottom) {
			ScrollView(showsIndicators: false) {
				LazyVStack {
					ForEach(self.pokemons, id: \.id) { pokemon in
						PokemonCell(pokemon: pokemon)
							.padding(.bottom, 12)
							.padding(.horizontal, 16)
					}
				}
				.padding(.bottom, 64)
			}
			
			Button(action: {
				print("OPEN SCAN")
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
		.task {
			var result: [Pokemon] = []
			
			do {
				for i in 1...151 {
					let response = try await PokemonWorker().fetch(id: i)
					result.append(response)
				}
				self.pokemons = result
			} catch {
				self.pokemons = result
			}
		}
	}
}

#Preview {
	ContentView()
}
