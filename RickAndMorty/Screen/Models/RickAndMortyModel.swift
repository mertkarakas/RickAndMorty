//
//  RickAndMortyModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

struct RickAndMortyModel {
	
	var id: Int = 0
	var image: String?
	var name: String?
	var status: StatusEnum?
	var species: String?
	var numberOfEpisodes: Int = 0
	var gender: String?
	var origin: CharacterOrigin?
	var location: CharacterLocation?
	var episodes: [String]?
	var lastEpisode: RickAndMortyCharacterEpisodeModel?
	var isFavorite: Bool = false
}
