//
//  UserDefaultsExtension.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

extension UserDefaults {
	
	private enum Keys {
	
		static let favoriteList = "favoriteList"
	}
	class var favoriteList: Any {
		get {
			return UserDefaults.standard.object(forKey: Keys.favoriteList) as Any
		}
		set {
			UserDefaults.standard.set(newValue, forKey: Keys.favoriteList)
		}
	}
}
