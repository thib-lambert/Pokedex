//
//  PokemonScanInteractor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import CoreImage
import Vision

class PokemonScanInteractor: Interactor<PokemonScanViewProperties, PokemonScanPresenter> {
	
	// MARK: - Variables
	private let cameraManager = CameraManager()
	private var canAnalyze = true
	
	func startScan() {
		Task {
			do {
				try await self.cameraManager.setup()
				try await self.cameraManager.start()
				
				Task {
					for await image in self.cameraManager.imagesStream {
						Task { @MainActor in
							self.presenter.update(CIContext().createCGImage(image, from: image.extent))
							
							do {
								let result = try self.analyze(image: image)
								self.presenter.update(pokemon: result?.0)
							} catch {
					#warning("Log error")
								print(error)
							}
						}
					}
				}
			} catch {
#warning("Log error")
			}
		}
	}
	
	func analyze(image: CIImage) throws -> (String, VNConfidence)? {
		defer { self.canAnalyze = true }
		self.canAnalyze = false
		
		let model = try VNCoreMLModel(for: PokemonClassifier(configuration: MLModelConfiguration()).model)
		
		let request = VNCoreMLRequest(model: model)
		let handler = VNImageRequestHandler(ciImage: image, options: [:])
		try handler.perform([request])
		
		guard let results = request.results as? [VNClassificationObservation],
			  let firstResult = results.first,
			  firstResult.confidence >= 0.85
		else { return nil }
		
		return (firstResult.identifier, firstResult.confidence)
	}
}
