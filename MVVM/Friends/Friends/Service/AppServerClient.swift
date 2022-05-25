//
//  AppServerClient.swift
//  Friends
//
//  Created by Alexandre Cardoso on 20/06/21.
//

import Foundation
import Alamofire

class AppServerClient {
	
	// MARK: - GetFriends
	enum GetFriendsFailureReason: Int, Error {
		case unAuthorized = 401
		case notFound = 404
	}
	
	typealias GetFriendsResult = Result<[Friend], GetFriendsFailureReason>
	typealias GetFriendsCompletion = (_ result: GetFriendsResult) -> Void
	
	func getFriends(completion: @escaping GetFriendsCompletion) {
		AF.request("http://friendservice.herokuapp.com/listFriends").validate()
			.responseJSON { response in
				
				switch response.result {
					case .success(_):
						let friends = [Friend]()
						completion(.success(friends))
						
					case .failure(_):
						if let statusCode = response.response?.statusCode,
							let reason = GetFriendsFailureReason(rawValue: statusCode) {
							completion(.failure(reason))
						}
						completion(.failure(.notFound))
				}
				

			}
	}
	
	func getFriends2(completion: @escaping GetFriendsCompletion) {
		AF.request("http://friendservice.herokuapp.com/listFriends").validate()
			.responseDecodable(of: [Friend].self) { response in
				
				switch response.result {
					case .success(let friends):
						completion(.success(friends))
						
					case .failure(_):
						if let statusCode = response.response?.statusCode,
							let reason = GetFriendsFailureReason(rawValue: statusCode) {
							completion(.failure(reason))
						}
						completion(.failure(.notFound))
				}
				
			}
	}
	
}


fileprivate extension AppServerClient.GetFriendsFailureReason {
	func getErrorMessage() -> String {
		switch self {
			case .unAuthorized:
				return "Please login to load your friends"
			case .notFound:
				return "Cloud not"
		}
	}
}
