//
//  RickAndMortyListCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation
import UIKit

final class RickAndMortyCollectionViewCell: UICollectionViewCell {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var statusLabel: UILabel!
	@IBOutlet private weak var speciesLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet private weak var starLabel: UILabel!
	@IBOutlet weak var statusIndicatorView: UIView!
	
	// MARK: - Privates
	
	private var task: URLSessionDataTask?
	
	// MARK: - Cell Reuse
	
	override func prepareForReuse() {
		
		/* Prevent task resumes when cell reuse */
		
		task?.cancel()
		task = nil
		self.imageView.image = nil
		
		self.statusIndicatorView.layer.borderWidth = 0.0
		self.statusIndicatorView.layer.borderColor = UIColor.clear.cgColor
	}
	
	// MARK: - Configure
	
	public func configureCell(imageLink: String?, name: String?, status: StatusEnum?, species: String?, isFavorite: Bool) {
		
		self.starLabel.isHidden = !isFavorite
		self.nameLabel.text = name
		self.speciesLabel.text = species
		if let charStatus = status {
			self.statusLabel.text = charStatus.rawValue
			self.drawStatusCircle(status: charStatus)
		}
		
		if self.task == nil {
			self.task = self.imageView.setImage(from: imageLink ?? "", contentMode: .scaleAspectFill)
		}
	}
	
	private func drawStatusCircle(status: StatusEnum) {
		
		self.statusIndicatorView.layer.cornerRadius = self.statusIndicatorView.frame.size.width/2
		self.statusIndicatorView.clipsToBounds = true
		
		switch status {
		case .dead:
			self.statusIndicatorView.backgroundColor = UIColor.systemRed
			break
		case .alive:
			self.statusIndicatorView.backgroundColor = UIColor.systemGreen
			break
		case .unknown:
			self.statusIndicatorView.backgroundColor = UIColor.clear
			self.statusIndicatorView.layer.borderColor = UIColor.systemGray.cgColor
			self.statusIndicatorView.layer.borderWidth = 1.0
			break
		}
	}
}
