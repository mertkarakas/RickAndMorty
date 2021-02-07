//
//  JSONDecoderDateExtension.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

extension JSONDecoder {
	
	var dateDecodingStrategyFormatters: [DateFormatter]? {
		@available(*, unavailable, message: "This variable is meant to be set only")
		get { return nil }
		set {
			guard let formatters = newValue else { return }
			self.dateDecodingStrategy = .custom { decoder in

				let container = try decoder.singleValueContainer()
				let dateString = try container.decode(String.self)

				for formatter in formatters {
					if let date = formatter.date(from: dateString) {
						return date
					}
				}

				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
			}
		}
	}
}
