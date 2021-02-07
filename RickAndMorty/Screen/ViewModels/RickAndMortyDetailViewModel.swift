//
//  RickAndMortyDetailViewModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

final class RickAndMortyDetailViewModel {
	
	// Privates
	
	private var characterModel: RickAndMortyModel!
	
	// Delegate
	
	var delegate: RickAndMortyDetailViewModelDelegate?
	
	// MARK: - initialize VM
	
	init(detail: RickAndMortyModel) {
		self.characterModel = detail
	}
	
	// MARK: - VM Methods
	
	func updateView() {
		
		self.getEpisodeDetails()
	}
	
	func makeFavorite() {
		
		if (self.characterModel.isFavorite) {
			UserDefaultsManager.shared.removeObject(id: self.characterModel.id)
			self.characterModel.isFavorite = false
		}
		else {
			UserDefaultsManager.shared.insertObject(id: self.characterModel.id)
			self.characterModel.isFavorite = true
		}
		self.delegate?.updateStar(self.characterModel.isFavorite)
		print(UserDefaults.favoriteList)
	}
	
	private func getEpisodeDetails() {
		
		Services.getEpisodeDetail(page: self.characterModel.episodes?.last ?? "") { [weak self] (result) in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				if let episodeName = response.name, let airDate = response.airDate {
					self.characterModel.lastEpisode = RickAndMortyCharacterEpisodeModel(name: episodeName, airDate: self.convertDateToString(date: airDate))
					self.delegate?.viewUpdate(self.characterModel)
				}
				break
			case .failure(let error):
				break
			}
		}
	}
	
	private func convertDateToString(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM dd, yyyy"
		return dateFormatter.string(from: date)
	}
}
