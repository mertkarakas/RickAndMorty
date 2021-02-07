//
//  Services.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

final class Services {
	
	class func getAllResources(completion: @escaping(Swift.Result<BaseApiResponseModel, ServiceErrorModel>) -> Void) {
		ServiceManager.shared.sendRequest(request: BaseApiRequestModel()) { (result) in
			completion(result)
		}
	}
	
	class func getAllCharacters(page: String, completion: @escaping(Swift.Result<CharacterResponseModel, ServiceErrorModel>) -> Void) {
		ServiceManager.shared.sendRequest(request: GetAllCharactersRequestModel(page: page)) { (result) in
			completion(result)
		}
	}
	
	class func getCharacterById(id: Int, completion: @escaping(Swift.Result<CharacterResponseResultModel, ServiceErrorModel>) -> Void) {
		ServiceManager.shared.sendRequest(request: GetCharacterByIdRequestModel(id: id)) { (result) in
			completion(result)
		}
	}
	
	class func getEpisodeDetail(page: String, completion: @escaping(Swift.Result<EpisodeResponseModel, ServiceErrorModel>) -> Void) {
		ServiceManager.shared.sendRequest(request: GetEpisodeByIdRequestModel(page: page)) { (result) in
			completion(result)
		}
	}

}
