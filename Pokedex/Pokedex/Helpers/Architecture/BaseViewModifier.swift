//
//  BaseViewModifier.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import SwiftUI

private struct BaseViewModifier<
	V: ViewProperties,
	P: Presenter<V>,
	I: Interactor<V, P>
>: ViewModifier {
	
	// MARK: - Variables
	private let interactor: I
	@ObservedObject private var viewProperties: V
	
	// MARK: - Init
	init(interactor: I, viewProperties: V) {
		self.viewProperties = viewProperties
		self.interactor = interactor
		self.interactor.set(viewProperties: viewProperties)
	}
	
	// MARK: - Functions
	func body(content: Content) -> some View {
		content
	}
}

extension View {
	
	func setup<
		V: ViewProperties,
		P: Presenter<V>,
		I: Interactor<V, P>
	>(with interactor: I, and viewProperties: V) -> some View {
		self.modifier(BaseViewModifier(interactor: interactor, viewProperties: viewProperties))
	}
}
