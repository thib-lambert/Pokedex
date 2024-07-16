//
//  Interactor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 15/07/2024.
//

import Foundation

class Interactor<V: ViewProperties, P: Presenter<V>> {
	
	// MARK: - Variables
	let presenter: P
	
	// MARK: - Init
	required init() {
		self.presenter = P()
	}
	
	// MARK: - Setup
	func set(viewProperties: V) {
		self.presenter.set(viewProperties: viewProperties)
	}
}
