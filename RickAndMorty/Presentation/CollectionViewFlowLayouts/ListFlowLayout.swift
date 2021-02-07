//
//  ListFlowLayout.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation
import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
	
	// MARK: - Constants

	let itemHeight: CGFloat = 150
	
	// MARK: - Initialize
	
	override init() {
		super.init()
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
	
	func setupLayout() {
		minimumInteritemSpacing = 0
		minimumLineSpacing = 1
		scrollDirection = .vertical
	}
	
	var itemWidth: CGFloat {
		
		return collectionView!.frame.width
	}
	
	override var itemSize: CGSize {
		set {
			self.itemSize = CGSize(width: itemWidth, height: itemHeight)
		}
		get {
			return CGSize(width: itemWidth, height: itemHeight)
		}
	}
	
	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
		return collectionView!.contentOffset
	}
}
