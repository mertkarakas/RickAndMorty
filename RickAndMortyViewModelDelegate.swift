//
//  RickAndMortyViewModelDelegate.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

protocol RickAndMortyViewModelDelegate {
	
	func viewUpdate(characters: [RickAndMortyModel])
	func modelUpdate(_ character: RickAndMortyModel)
	func showMessage(_ title: String?, message: String?)
	func canLoadMore(_ canLoadMore: Bool)
	func goToDetail(with character: RickAndMortyModel)
}
