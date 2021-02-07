//
//  EpisodeResponseModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

struct EpisodeResponseModel: Codable {
	
	var id: Int = 0
	var airDate: Date?
	var episode: String?
	var name: String?
	var characters: [String]?
	var url: String?
	var created: Date?
}

extension EpisodeResponseModel {
	
	private enum CodingKeys: String, CodingKey {
		
		case id
		case airDate = "air_date"
		case name
		case episode
		case characters
		case url
		case created
	}
}
