//
//  Logger+Pokedex.swift
//  Pokedex
//
//  Created by Thibaud Lambert on 18/07/2024.
//

import Foundation
import os

extension Logger {
	
	init(subsystem: String) {
		self.init(subsystem: subsystem, category: "")
	}
}
