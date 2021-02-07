//
//  ServiceErrorModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

enum ErrorKey: String {
	case general = "Something went wrong"
	case parse = "Parse error!"
}

final class ServiceErrorModel: Error {
	
	// MARK: - Properties
	
	var statusMessage: String?
	
	init(_ message: String) {
		self.statusMessage = message
	}
}

// MARK: - Public Functions

extension ServiceErrorModel {
	
	class func generalError() -> ServiceErrorModel {
		return ServiceErrorModel(ErrorKey.general.rawValue)
	}
	class func parserError() -> ServiceErrorModel {
		return ServiceErrorModel(ErrorKey.parse.rawValue)
	}
}
