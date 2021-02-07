//
//  RickAndMortyViewController.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 6.02.2021.
//

import UIKit

final class RickAndMortyViewController: BaseViewController {
	
	// MARK: - Outlets
	
	@IBOutlet weak var layoutBarButton: UIBarButtonItem!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet private weak var searchBarTopConstraint: NSLayoutConstraint!
	
	// MARK: - Constants
	
	private let footerReuseIdentifier = "CollectionViewFooter"
	private let characterDetailSegueIdentifier = "goCharacterDetail"
	private let characterCollectionCell = "RickAndMortyListCollectionViewCell"
	private let characterGridCollectionCell = "RickAndMortyGridCollectionViewCell"
	private let characterFooterView = "RickAndMortyCollectionViewFooterView"
	private let characterCellIdentifier = "characterCell"
	private let characterGridCellIdentifier = "characterGridCell"
	private let searchBarTopConstraintConstant: CGFloat = 8
	private let animationDuration: Double = 0.2
	private let layoutScaleForOffset: CGFloat = 2 / (GridFlowLayout().itemHeight / ListFlowLayout().itemHeight)
	
	// MARK: - Properties
	
	private lazy var viewModel: RickAndMortyViewModel = {
		return RickAndMortyViewModel()
	}()
	private var isLoadMore: Bool = true
	private var isGridLayout: Bool = false {
		didSet {
			updateLayout()
		}
	}
	private var characters: [RickAndMortyModel] = []
	
	// MARK: - LifeCycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set navigation title
		self.title = RickAndMortyConstants.title
		
		// update model
		self.viewModel.updateModel()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set delegates
		self.viewModel.delegate = self
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		self.searchBar.delegate = self
		self.searchBar.enablesReturnKeyAutomatically = false
		
		// Prepare UI
		self.prepareUI()
		
		// VM
		self.viewModel.prepareResources()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.collectionView.collectionViewLayout.invalidateLayout()
	}
	
	// MARK: - UI
	
	private func prepareUI() {
		
		// Register cell
		let nib = UINib(nibName: self.characterCollectionCell, bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: self.characterCellIdentifier)
		let nibForGrid = UINib(nibName: self.characterGridCollectionCell, bundle: nil)
		self.collectionView.register(nibForGrid, forCellWithReuseIdentifier: self.characterGridCellIdentifier)
		
		// Set layout
		self.updateLayout()
		
		// Hide search bar on load
		self.setSearchBarTopConstraint()
	}
	
	private func updateLayout() {
		
		let layout = self.isGridLayout ? GridFlowLayout() : ListFlowLayout()
		
		var collectionViewCurrentOffset = self.collectionView.contentOffset.y
		
		self.collectionView.reloadData()
		self.collectionView.collectionViewLayout.invalidateLayout()
		UIScreen.main.snapshotView(afterScreenUpdates: true)
		self.collectionView.setCollectionViewLayout(layout, animated: false)
		
		// Keep the collectionview offset on the same item when the layout change.
		if collectionViewCurrentOffset == 0 {
			return
		}
		let maxOffset = self.collectionView.contentSize.height - self.collectionView.bounds.height
		if (collectionViewCurrentOffset / self.layoutScaleForOffset) > maxOffset {
			collectionViewCurrentOffset = maxOffset
			self.collectionView.setContentOffset(CGPoint(x: 0, y: collectionViewCurrentOffset), animated: false)
		}
		else {
			self.collectionView.setContentOffset(CGPoint(x: 0, y: self.isGridLayout ? (collectionViewCurrentOffset / self.layoutScaleForOffset) : collectionViewCurrentOffset * self.layoutScaleForOffset), animated: false)
		}
	}
	
	// MARK: - SearchBar UI
	
	private func showSearchBar() {
		self.searchBarTopConstraint.constant = self.searchBarTopConstraintConstant
		self.searchBar.alpha = 1.0
	}
	
	private func hideSearchBar() {
		if self.searchTextExists() {
			self.searchBar.becomeFirstResponder()
			return
		}
		self.searchBar.alpha = 0.0
		self.searchBarTopConstraint.constant = -1 * self.searchBar.frame.height
		self.view.endEditing(true)
	}
	
	private func setSearchBarTopConstraint() {
		
		if self.searchBarTopConstraint.constant < 0 {
			showSearchBar()
		}
		else {
			hideSearchBar()
		}
	}
	
	private func searchTextExists() -> Bool{
		if let text = self.searchBar.text {
			if text.count > 0 {
				return true
			}
			else {
				return false
			}
		}
		return false
	}
	
	// MARK: - Actions
	
	@IBAction func searchButtonAction(_ sender: Any) {
		self.setSearchBarTopConstraint()
	}
	
	@IBAction func layoutButtonAction(_ sender: Any) {
		
		// Switch layout
		if self.isGridLayout {
			self.layoutBarButton.title = "[][]"
			self.isGridLayout = false
		}
		else {
			self.layoutBarButton.title = "[=]"
			self.isGridLayout = true
		}
	}
	
	// MARK: - Prepare Segue
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == self.characterDetailSegueIdentifier {
			let detailViewController = segue.destination as! RickAndMortyDetailViewController
			let characterModel = sender as! RickAndMortyModel
			let detailViewModel = RickAndMortyDetailViewModel(detail: characterModel)
			detailViewController.viewModel = detailViewModel
		}
	}
}

// MARK: - RickAndMorty Delegate Methods

extension RickAndMortyViewController: RickAndMortyViewModelDelegate {
	
	func viewUpdate(characters: [RickAndMortyModel]) {
		
		self.characters = characters
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
	
	func modelUpdate(_ character: RickAndMortyModel) {
		
		if let index = self.characters.firstIndex(where: {$0.id == character.id}) {
			self.characters[index] = character
			self.collectionView.reloadData()
		}
	}
	
	func goToDetail(with character: RickAndMortyModel) {
		self.performSegue(withIdentifier: self.characterDetailSegueIdentifier, sender: character)
	}
	
	func canLoadMore(_ canLoadMore: Bool) {
		self.isLoadMore = canLoadMore
	}
	
	func showMessage(_ title: String?, message: String?) {
		DispatchQueue.main.async {
			self.showAlert(with: title, message: message)
		}
	}
}

// MARK: - CollectionView Delegates

extension RickAndMortyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		self.characters.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		var cell: RickAndMortyCollectionViewCell = .init()
		if self.isGridLayout {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.characterGridCellIdentifier, for: indexPath) as! RickAndMortyCollectionViewCell
		}
		else {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.characterCellIdentifier, for: indexPath) as! RickAndMortyCollectionViewCell
		}
		
		let characterAtIndex = self.characters[indexPath.row]
		cell.imageView.image = nil
		cell.configureCell(imageLink: characterAtIndex.image, name: characterAtIndex.name, status: characterAtIndex.status, species: characterAtIndex.species, isFavorite: characterAtIndex.isFavorite)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		if kind == UICollectionView.elementKindSectionFooter {
			// register footer view
			let footerNib = UINib(nibName: self.characterFooterView, bundle: nil)
			self.collectionView.register(footerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerReuseIdentifier)
			
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.footerReuseIdentifier, for: indexPath) as! RickAndMortyCollectionViewFooterView
			footerView.isHidden = self.isLoadMore ? false : true
			footerView.configureFooter {
				
				self.viewModel.loadCharacters()
			}
			
			return footerView
		}
		return UICollectionReusableView()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let character = self.characters[indexPath.row]
		self.viewModel.didItemSelected(character)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RickAndMortyViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		
		return CGSize(width: self.collectionView.frame.width, height: 50.0)
	}
}

// MARK: - Search Bar Delegate

extension RickAndMortyViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
		self.viewModel.searchItem(searchText)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		self.searchBar.resignFirstResponder()
	}
}

// MARK: - ScrollView Delegate

extension RickAndMortyViewController: UIScrollViewDelegate {
	
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		
		let currentOffset = scrollView.contentOffset.y
		let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
		
		// Hide / Show search bar when scrolling
		
		if currentOffset > 100 {
			
			if searchTextExists() {
				return
			}
			UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut) {
				self.hideSearchBar()
				self.view.layoutIfNeeded()
			} completion: { [weak self] _ in
				self?.view.endEditing(true)
			}
		}
		else if currentOffset < 50 {
			
			UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseIn) {
				self.showSearchBar()
				self.view.layoutIfNeeded()
			}
		}
		
		// Load more automatically if scroll offset high
		if (currentOffset >= maximumOffset + self.searchBar.frame.height) && self.isLoadMore {
			
			self.viewModel.loadCharacters()
		}
	}
}
