//
//  GetCharacterByIdRequestModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

final class GetCharacterByIdRequestModel: BaseRequestModel {
	
	var id: Int = 0
	
	 init(id: Int) {
		self.id = id
	}
	
	override var path: String {
		return "/\(id)"
	}
	
	override var baseUrl: String {
		return BaseApiResponseModel.shared.characters ?? ""
	}
}
