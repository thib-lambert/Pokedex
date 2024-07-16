//
//  Presenter.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 15/07/2024.
//

import Foundation

class Presenter<V: ViewProperties> {
	
	// MARK: - Variables
	var viewProperties: V!
	
	// MARK: - Init
	required init() { }
	
	// MARK: - Setup
	func set(viewProperties: V) {
		self.viewProperties = viewProperties
	}
	
	// MARK: - Display
	func display() {
		Task { @MainActor in
			self.viewProperties.objectWillChange.send()
		}
	}
}
