//
//  TypeTagView.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 17/07/2024.
//

import Foundation
import SwiftUI
import PokedexDataKit

struct TypeTagView: View {
	
	// MARK: - Variables
	let type: Types
	let fontSize: CGFloat
	
	// MARK: - Body
	var body: some View {
		HStack(spacing: 4) {
			Image(self.type.picto)
				.resizable()
				.scaledToFit()
				.padding(4)
				.frame(width: 20, height: 20)
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
	init(type: Types, fontSize: CGFloat = 11) {
		self.type = type
		self.fontSize = fontSize
	}
}
