//
//  DateFormatterExtension.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

extension DateFormatter {
	
	static let createdDateFormat: DateFormatter = {
		var dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
		return dateFormatter
	}()
	
	static let airDateFormat: DateFormatter = {
		var dateFormatter = DateFormatter()
		//September 27, 2015
		dateFormatter.dateFormat = "MMMM dd, yyyy"
		return dateFormatter
	}()
}
