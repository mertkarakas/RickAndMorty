//
//  BaseRequestModel.swift
//  RickAndMorty
//
//  Created by Mert KARAKAŞ on 7.02.2021.
//

import Foundation

enum RequestHTTPMethod: String {
	
	case get = "get"
	case post = "post"
}

open class BaseRequestModel: NSObject {
	
	// MARK: - Properties
	
	var baseUrl: String {
		return ""
	}
	
	var path: String {
		return ""
	}
	var parameters: [String: Any] {
		return [:]
	}
	var headers: [String: String] {
		return [:]
	}
	var method: RequestHTTPMethod {
		return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
	}
	var body: [String: Any?] {
		return [:]
	}
}

// MARK: - Public Functions

extension BaseRequestModel {
	
	func urlRequest() -> URLRequest {
		
		var components = URLComponents(url: URL(string: baseUrl == "" ? ServiceConstants.baseURL : baseUrl)!, resolvingAgainstBaseURL: true)!
		
		var queryItems: [URLQueryItem] = []
		
		let otherParams: [URLQueryItem] = parameters.map({
			return URLQueryItem(name: $0.key, value: $0.value as? String)
		})
		queryItems.append(contentsOf: otherParams)
		
		components.path += path
		components.queryItems?.append(contentsOf: queryItems)
		
		var request = URLRequest(url: components.url!)

		request.httpMethod = method.rawValue
		
		for header in headers {
			request.addValue(header.value, forHTTPHeaderField: header.key)
		}
		
		if method == RequestHTTPMethod.post {
			do {
				request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
			} catch let error {
				print(error.localizedDescription)
			}
		}
		
		return request
	}
}
