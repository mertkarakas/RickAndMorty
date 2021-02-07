//
//  BaseApiResponseModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

struct BaseApiResponseModel: Codable {
		
	static var shared: BaseApiResponseModel = BaseApiResponseModel()
	
	var characters: String?
	var locations: String?
	var episodes: String?
	
	init() {}
	
	mutating func map(characters: String?, locations: String?, episodes: String?) {
		self.characters = characters
		self.locations = locations
		self.episodes = episodes
	}
}
