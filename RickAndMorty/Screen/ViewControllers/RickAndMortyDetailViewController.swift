//
//  RickAndMortyDetailViewController.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation
import UIKit

final class RickAndMortyDetailViewController: BaseViewController {
	
	// MARK: - Outlets
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var statusLabel: UILabel!
	@IBOutlet private weak var speciesLabel: UILabel!
	@IBOutlet private weak var numberOfEpisodeLabel: UILabel!
	@IBOutlet private weak var genderLabel: UILabel!
	@IBOutlet private weak var originLabel: UILabel!
	@IBOutlet private weak var lastLocationLabel: UILabel!
	@IBOutlet private weak var lastSeenEpisodeLabel: UILabel!
	
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var favoriteButton: UIBarButtonItem!
	
	// MARK: - Properties
	
	var viewModel: RickAndMortyDetailViewModel?
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.viewModel?.delegate = self
		self.viewModel?.updateView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	// MARK: - UI
	
	func statusLabelColor(status: StatusEnum) -> UIColor {
		
		switch status {
		case .alive:
			return UIColor.systemGreen
		case .dead:
			return UIColor.systemRed
		default:
			return UIColor.systemGray
		}
	}
	
	// MARK: - Actions
	@IBAction private func favoriteButtonAction(_ sender: UIBarButtonItem) {
		
		self.viewModel?.makeFavorite()
	}
}

extension RickAndMortyDetailViewController: RickAndMortyDetailViewModelDelegate {
	
	func viewUpdate(_ characterModel: RickAndMortyModel) {
		
		DispatchQueue.main.async {
			self.nameLabel.text = characterModel.name
			self.statusLabel.text = "Status: \(characterModel.status?.rawValue ?? "")"
			self.statusLabel.textColor = self.statusLabelColor(status: characterModel.status ?? .unknown)
			self.speciesLabel.text = "Species: \(characterModel.species ?? "")"
			self.numberOfEpisodeLabel.text = "Number of episodes: \(characterModel.numberOfEpisodes)"
			self.genderLabel.text = "Gender: \(characterModel.gender ?? "")"
			self.originLabel.text = "Origin: \(characterModel.origin?.name ?? "")"
			self.lastLocationLabel.text = "Last seen location: \(characterModel.location?.name ?? "")"
			self.lastSeenEpisodeLabel.text = "Last seen episode name: \(characterModel.lastEpisode?.episodeName ?? "")\nAir Date: \(characterModel.lastEpisode?.episodeAirDate ?? "")"

			self.imageView.setImage(from: characterModel.image ?? "", contentMode: .scaleToFill)
		}
		self.updateStar(characterModel.isFavorite)
	}
	
	func updateStar(_ isFavorite: Bool) {
		if (isFavorite) {
			self.favoriteButton.title = "★"
		}
		else {
			self.favoriteButton.title = "☆"
		}
	}
}
