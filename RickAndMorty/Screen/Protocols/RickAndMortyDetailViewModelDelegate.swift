//
//  RickAndMortyDetailViewModelDelegate.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

protocol RickAndMortyDetailViewModelDelegate {
	
	func viewUpdate(_ characterDetailModel: RickAndMortyModel)
	func updateStar(_ isFavorite: Bool)
}
