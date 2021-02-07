//
//  ServiceManager.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation
import UIKit

final class ServiceManager {
	
	// MARK: - Properties
	
	public static let shared: ServiceManager = ServiceManager()
}

// MARK: - Public Functions

extension ServiceManager {
	
	func sendRequest<T: Codable>(request: BaseRequestModel, completion: @escaping(Swift.Result<T, ServiceErrorModel>) -> Void) {
		
		// Show Indicator
		guard let baseViewController: BaseViewController = UIApplication.getTopViewController() as? BaseViewController else {
			return
		}
		baseViewController.showLoading()
		
		URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
			// Hide indicator
			DispatchQueue.main.async {
				baseViewController.hideLoading()
			}
			guard let data = data, var responseModel = try? JSONDecoder().decode(BaseResponseModel<T>.self, from: data) else {
				completion(Result.failure(ServiceErrorModel(ErrorMessagesConstants.mapModelError)))
				return
			}
			
			responseModel.rawData = data
			print(responseModel.json ?? "")
			
			if let data = responseModel.data {
				completion(Result.success(data))
			} else {
				completion(Result.failure(responseModel.error))
			}
			
		}.resume()
	}
}
