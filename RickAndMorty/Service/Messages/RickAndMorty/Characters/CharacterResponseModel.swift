//
//  CharacterResponseModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

struct CharacterResponseModel: Codable {
	
	var info: CharacterResponseInfoModel?
	var results: [CharacterResponseResultModel]?
}

struct CharacterResponseInfoModel: Codable {
	
	var count: Int = 0
	var pages: Int = 0
	var next: String?
	var prev: String?
}

struct CharacterResponseResultModel: Codable {
	
	var id: Int = 0
	var name: String?
	var status: StatusEnum?
	var species: String?
	var type: String?
	var gender: String?
	var origin: CharacterOrigin?
	var location: CharacterLocation?
	var image: String?
	var episode: [String]?
	var url: String?
	var created: Date?
}

struct CharacterOrigin: Codable {
	
	var name: String?
	var url: String?
}

struct CharacterLocation: Codable {
	
	var name: String?
	var url: String?
}

enum StatusEnum: String, Codable {
	case dead = "Dead"
	case alive = "Alive"
	case unknown = "unknown"
}
