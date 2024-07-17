//
//  PokemonScanView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import SwiftUI

struct PokemonScanView: View {
	
	// MARK: - Variables
	private let interactor = PokemonScanInteractor()
	@ObservedObject private var viewProperties: PokemonScanViewProperties
	
	// MARK: - Body
	var body: some View {
		GeometryReader { geo in
			ZStack {
				if let image = self.viewProperties.image {
					Image(decorative: image, scale: 1)
						.resizable()
						.scaledToFill()
						.ignoresSafeArea()
						.frame(width: geo.size.width,
							   height: geo.size.height)
				}
				
				if let pokemon = self.viewProperties.pokemon {
					VStack {
						Text(LocalizedStringKey(pokemon))
							.font(.system(size: 20, weight: .bold))
							.foregroundStyle(.white)
							.frame(width: geo.size.width)
							.padding(.vertical, 12)
							.background(Color.gray)
						
						Spacer()
					}
				}
				
				self.closeButton
			}
		}
		.setup(with: self.interactor, and: self.viewProperties)
		.onAppear {
			self.interactor.startScan()
		}
	}
	
	@MainActor
	private var closeButton: some View {
		VStack {
			Spacer()
			
			HStack {
				Spacer()
				
				Button(action: {
#warning("Close view")
					print("CLOSE")
				}, label: {
					Image(systemName: "xmark")
						.resizable()
						.scaledToFit()
						.padding(8)
						.frame(width: 32, height: 32)
						.foregroundStyle(.white)
						.background(Color.red)
						.clipShape(Circle())
				})
			}
		}
		.padding(.trailing, 16)
		.padding(.bottom, 16)
	}
	
	// MARK: - Init
	init(viewProperties: PokemonScanViewProperties = PokemonScanViewProperties()) {
		self.viewProperties = viewProperties
	}
}

#Preview {
	PokemonScanView(viewProperties: .previewWithImageAndTitle)
}
