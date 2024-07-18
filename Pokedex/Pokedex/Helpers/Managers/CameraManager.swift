//
//  CameraManager.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 16/07/2024.
//

import Foundation
import AVFoundation
import CoreImage
import os

protocol CameraManagerDelegate: AnyObject {
	
	func didReceive(image: CIImage)
}

class CameraManager: NSObject {
	
	// MARK: - Variables
	fileprivate lazy var logger = Logger(subsystem: "\(Self.self)")
	private var captureSession: AVCaptureSession?
	private let sessionQueue = DispatchQueue(label: "CameraManagerSessionQueue")
	private let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
												 for: .video,
												 position: .back)
	private var deviceInput: AVCaptureDeviceInput?
	private var videoOutput: AVCaptureVideoDataOutput?
	
	weak var delegate: CameraManagerDelegate?
	
	var isAuthorized: Bool {
		get async {
			switch AVCaptureDevice.authorizationStatus(for: .video) {
			case .notDetermined: return await AVCaptureDevice.requestAccess(for: .video)
			case .authorized: return true
			default: return false
			}
		}
	}
	
	// MARK: - Init
	deinit {
		self.captureSession?.stopRunning()
		
		self.deviceInput = nil
		self.videoOutput = nil
		self.captureSession = nil
		
		self.logger.debug("\(Self.self) was destroyed !")
	}
	
	// MARK: - Setup
	func setup() async throws {
		guard await self.isAuthorized
		else { throw CameraManager.Error.needToBeAuthorize }
		
		self.captureSession = AVCaptureSession()
		guard let captureSession
		else { throw CameraManager.Error.invalidSession }
		
		guard let camera
		else { throw CameraManager.Error.invalidCamera }
		
		self.deviceInput = try AVCaptureDeviceInput(device: camera)
		captureSession.beginConfiguration()
		
		self.videoOutput = AVCaptureVideoDataOutput()
		self.videoOutput?.setSampleBufferDelegate(self, queue: self.sessionQueue)
		
		guard let deviceInput,
			  captureSession.canAddInput(deviceInput)
		else { throw CameraManager.Error.cannotAddInput }
		
		guard let videoOutput,
			  captureSession.canAddOutput(videoOutput)
		else { throw CameraManager.Error.cannotAddOutput }
		
		captureSession.addInput(deviceInput)
		captureSession.addOutput(videoOutput)
		
		guard let connection = videoOutput.connection(with: .video),
			  connection.isVideoRotationAngleSupported(90)
		else { throw CameraManager.Error.videoOrientationNotSupported }
		
		connection.videoRotationAngle = 90
		
		captureSession.commitConfiguration()
	}
	
	// MARK: - Start
	func start() async throws {
		guard await self.isAuthorized
		else { throw CameraManager.Error.needToBeAuthorize }
		
		guard let captureSession
		else { throw CameraManager.Error.invalidSession }
		
		captureSession.startRunning()
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
			self.logger.fault("\(Self.self) - Unable to get image")
			return
		}
		
		let ciImage = CIImage(cvPixelBuffer: imagePixelBuffer)
		
		self.delegate?.didReceive(image: ciImage)
	}
}

// MARK: - Error
extension CameraManager {
	
	enum Error: LocalizedError {
		
		case needToBeAuthorize,
			 invalidCamera,
			 cannotAddInput,
			 cannotAddOutput,
			 videoOrientationNotSupported,
			 invalidSession
		
		var errorDescription: String? {
			switch self {
			case .needToBeAuthorize: return "Permission required to use the camera !"
			case .invalidCamera: return "Invalid camera !"
			case .cannotAddInput: return "Input cannot be added !"
			case .cannotAddOutput: return "Output cannot be added !"
			case .videoOrientationNotSupported: return "Orientation angle is not supported !"
			case .invalidSession: return "Invalid session !"
			}
		}
	}
}
