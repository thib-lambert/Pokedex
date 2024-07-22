//
//  PokemonScanInteractor.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import CoreImage
import Vision
import os

class PokemonScanInteractor: Interactor<PokemonScanViewProperties, PokemonScanPresenter> {
	
	// MARK: - Variables
	private lazy var cameraManager: CameraManager = {
		let camera = CameraManager()
		camera.delegate = self
		
		return camera
	}()
	
	fileprivate lazy var logger = Logger(subsystem: "\(Self.self)")
	private var canAnalyze = true
	
	func startScan() {
		Task {
			do {
				try await self.cameraManager.setup()
				try await self.cameraManager.start()
			} catch {
				self.logger.fault("\(error.localizedDescription)")
			}
		}
	}
	
	private func analyze(image: CIImage) throws -> (String, VNConfidence)? {
		defer { self.canAnalyze = true }
		self.canAnalyze = false
		
		let model = try VNCoreMLModel(for: PokemonClassifier(configuration: MLModelConfiguration()).model)
		
		let request = VNCoreMLRequest(model: model)
		let handler = VNImageRequestHandler(ciImage: image, options: [:])
		try handler.perform([request])
		
		guard let results = request.results as? [VNClassificationObservation],
			  let firstResult = results.first,
			  firstResult.confidence >= 0.98
		else { return nil }
		
		return (firstResult.identifier, firstResult.confidence)
	}
}

extension PokemonScanInteractor: CameraManagerDelegate {
	
	func didReceive(image: CIImage) {
		self.presenter.update(CIContext().createCGImage(image, from: image.extent))
		
		do {
			let result = try self.analyze(image: image)
			self.presenter.update(pokemon: result?.0)
		} catch {
			self.logger.fault("\(error.localizedDescription)")
		}
	}
}
