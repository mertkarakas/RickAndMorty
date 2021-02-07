//
//  GetEpisodeByIdRequestModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

final class GetEpisodeByIdRequestModel: BaseRequestModel {
	
	var pageUrlString: String?
	
	 init(page: String) {
		self.pageUrlString = page
	}
	
	override var baseUrl: String {
		if let page = self.pageUrlString {
			if page.count > 0 {
				return page
			}
		}
		return BaseApiResponseModel.shared.episodes ?? ""
	}
}
