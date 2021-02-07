//
//  RickAndMortyModelMapper.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

final class RickAndMortyModelMapper {
	
	static func map(model: CharacterResponseResultModel) -> RickAndMortyModel {
		
		var characterModel: RickAndMortyModel = .init()

		characterModel.id = model.id
		characterModel.name = model.name
		characterModel.status = model.status
		characterModel.species = model.species
		characterModel.isFavorite = UserDefaultsManager.shared.isFavorite(id: model.id)
		characterModel.image = model.image
		characterModel.numberOfEpisodes = model.episode?.count ?? 0
		characterModel.episodes = model.episode
		characterModel.gender = model.gender
		characterModel.origin = model.origin
		characterModel.location = model.location
		
		return characterModel
	}
}
