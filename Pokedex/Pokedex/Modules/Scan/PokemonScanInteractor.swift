//
//  PokemonScanInteractor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation

class PokemonScanInteractor: Interactor<PokemonScanViewProperties, PokemonScanPresenter> {
	
	// MARK: - Variables
	private let cameraManager = CameraManager()
	
	func startScan() {
		Task {
			do {
				try await self.cameraManager.setup()
				try await self.cameraManager.start()
				
				Task {
					for await image in self.cameraManager.imagesStream {
						Task { @MainActor in
							self.presenter.update(image)
						}
					}
				}
			} catch {
				#warning("Log error")
			}
		}
	}
}
