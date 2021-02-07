//
//  RickAndMortyViewModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

final class RickAndMortyViewModel {
	
	// Properties
	
	private var characters: [RickAndMortyModel] = []
	private var nextPageUrlString: String?
	private var totalPage: Int = -1
	private var lastSelectedItemIndex = -1
	
	// Delegate
	var delegate: RickAndMortyViewModelDelegate?
	
	
	// MARK: - VM Methods
	
	public func prepareResources() {
		
		Services.getAllResources { [weak self] result in
			switch result {
			case .success(let response):
				BaseApiResponseModel.shared.map(characters: response.characters, locations: response.locations, episodes: response.episodes)
				DispatchQueue.main.async {
					self?.getCharacters()
				}
				break
			case .failure(let error):
				self?.delegate?.showMessage(nil, message: error.statusMessage ?? error.localizedDescription)
				break
			}
		}
	}
	
	public func loadCharacters() {
		// Fetch characters
		if let _ = self.nextPageUrlString {
			self.getCharacters()
		}
	}
	
	public func updateModel() {
		
		if lastSelectedItemIndex < 0 {
			return
		}
		
		self.characters[lastSelectedItemIndex].isFavorite = self.updateFavoriteByCharacterId(self.characters[lastSelectedItemIndex].id)
		self.delegate?.modelUpdate(self.characters[lastSelectedItemIndex])
	}
	
	public func didItemSelected(_ character: RickAndMortyModel) {
		
		if let charIndex = self.characters.firstIndex(where: { $0.id == character.id }) {
			self.lastSelectedItemIndex = charIndex
		}
		Services.getCharacterById(id: character.id) { [weak self] result in
			switch result {
			case .success(let response):
				DispatchQueue.main.async {
					let mappedModel = RickAndMortyModelMapper.map(model: response)
					self?.delegate?.goToDetail(with: mappedModel)
				}
				break
			case .failure(let error):
				self?.delegate?.showMessage(nil, message: error.statusMessage ?? error.localizedDescription)
				break
			}
		}
	}
	
	func searchItem(_ text: String?) {
		
		guard let text = text else {
			return
		}
		if text == "" {
			self.delegate?.canLoadMore(true)
			self.delegate?.viewUpdate(characters: self.characters)
			return
		}
		let filteredCharacters: [RickAndMortyModel] = self.characters.filter({ $0.name?.lowercased().contains(text.lowercased()) != false ||
																			$0.status?.rawValue.lowercased().contains(text.lowercased()) != false })
		
		self.delegate?.canLoadMore(false)
		self.delegate?.viewUpdate(characters: filteredCharacters)
	}
	
	// MARK: - Private Methods
	
	private func getCharacters() {
		
		Services.getAllCharacters(page: self.nextPageUrlString ?? "") { [weak self] result in
			switch result {
			case .success(let response):
				guard let results = response.results else {
					return
				}
				let model = results.map({ return RickAndMortyModelMapper.map(model: $0) })
				self?.characters.append(contentsOf: model)
				if let nextPage = response.info?.next {
					self?.nextPageUrlString = nextPage
				}
				else {
					self?.delegate?.canLoadMore(false)
				}
				self?.totalPage = response.info?.pages ?? 0
				self?.delegate?.viewUpdate(characters: self?.characters ?? [])
				break
			case.failure(let error):
				self?.delegate?.showMessage(nil, message: error.statusMessage ?? error.localizedDescription)
				break
			}
		}
	}
	
	private func updateFavoriteByCharacterId(_ id: Int) -> Bool {
		return UserDefaultsManager.shared.isFavorite(id: id)
	}
}
