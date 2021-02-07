//
//  RickAndMortyCharacterEpisodeModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

struct RickAndMortyCharacterEpisodeModel {
	
	var episodeName: String?
	var episodeAirDate: String?
	
	init (name: String, airDate: String) {
		self.episodeName = name
		self.episodeAirDate = airDate
	}
}
