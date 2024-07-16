//
//  CameraManager.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import AVFoundation
import CoreImage

class CameraManager: NSObject {
	
	// MARK: - Variables
	private let captureSession = AVCaptureSession()
	private let sessionQueue = DispatchQueue(label: "CameraManagerSessionQueue")
	private let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
												 for: .video,
												 position: .back)
	private var addToPreviewStream: ((CGImage) -> Void)?
	
	var isAuthorized: Bool {
		get async {
			switch AVCaptureDevice.authorizationStatus(for: .video) {
			case .notDetermined: return await AVCaptureDevice.requestAccess(for: .video)
			case .authorized: return true
			default: return false
			}
		}
	}
	
	lazy var imagesStream: AsyncStream<CGImage> = {
		AsyncStream { continuation in
			self.addToPreviewStream = { image in
				continuation.yield(image)
			}
		}
	}()
	
	// MARK: - Init
	deinit {
		self.captureSession.stopRunning()
	}
	
	// MARK: - Setup
	func setup() async throws {
		guard await self.isAuthorized
		else { throw CameraManager.Error.needToBeAuthorize }
		
		guard let camera
		else { throw CameraManager.Error.invalidCamera }
		
		let deviceInput = try AVCaptureDeviceInput(device: camera)
		self.captureSession.beginConfiguration()
		
		let videoOutput = AVCaptureVideoDataOutput()
		videoOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
		
		guard self.captureSession.canAddInput(deviceInput)
		else { throw CameraManager.Error.cannotAddInput }
		
		guard self.captureSession.canAddOutput(videoOutput)
		else { throw CameraManager.Error.cannotAddOutput }
		
		self.captureSession.addInput(deviceInput)
		self.captureSession.addOutput(videoOutput)
		
		guard let connection = videoOutput.connection(with: .video),
			  connection.isVideoOrientationSupported
		else { throw CameraManager.Error.videoOrientationNotSupported }
		
		connection.videoOrientation = .portrait
		
		self.captureSession.commitConfiguration()
	}
	
	// MARK: - Start
	func start() async throws {
		guard await self.isAuthorized
		else { throw CameraManager.Error.needToBeAuthorize }
		
		self.captureSession.startRunning()
	}
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
	
	func captureOutput(_ output: AVCaptureOutput,
					   didOutput sampleBuffer: CMSampleBuffer,
					   from connection: AVCaptureConnection) {
		let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(sampleBuffer)
		guard let imagePixelBuffer = pixelBuffer
		else {
#warning("Add log error")
			//			log(.camera, "\(Self.self) - Unable to get image from sample buffer")
			return
		}
		
		let ciImage = CIImage(cvPixelBuffer: imagePixelBuffer)
		
		guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)
		else {
#warning("Add log error")
			//			log(.camera, "\(Self.self) - Unable to get image from sample buffer")
			return
		}
		
		self.addToPreviewStream?(cgImage)
	}
}

// MARK: - Error
extension CameraManager {
	
	enum Error: LocalizedError {
		
		case needToBeAuthorize,
			 invalidCamera,
			 cannotAddInput,
			 cannotAddOutput,
			 videoOrientationNotSupported
		
		var errorDescription: String? {
			switch self {
			case .needToBeAuthorize:
#warning("Add translation")
				return "NEED AUTHORIZATION"
				
			case .invalidCamera:
#warning("Add translation")
				return "NEED CAMERA"
				
			case .cannotAddInput:
#warning("Add translation")
				return "NEED INPUT"
				
			case .cannotAddOutput:
#warning("Add translation")
				return "NEED OUTPUT"
				
			case .videoOrientationNotSupported:
#warning("Add translation")
				return "NEED ORIENTATION"
			}
		}
	}
}
