//
//  UserPresenter.swift
//  Exemplo_01
//
//  Created by Alexandre Cardoso on 26/07/21.
//

import Foundation


// Interface dos métodos para a Presenter
// protocol ItemsViewPresenter: AnyObject {
//		init(view: ItemsView)		-> ViewData
protocol UserPresenterProtocol: AnyObject {
	func fetchUsers()
	func sortByName()
	func sortByAge()
}

// Metodos para View
// protocol ItemsView: AnyObject {  -> ViewData
protocol UserPresenterDelegate: AnyObject {
	func render(errorMessage: String)
	func renderLoading()
	func render(users: [UserViewModel])
}

// Implementação do Presenter <Interface>
// class ItemsPresenter: ItemsViewPresenter {
class UserPresenter: UserPresenterProtocol {
	private let service: UserServiceProtocol
	private weak var delegate: UserPresenterDelegate?
	private var users = [User]()
	private var viewUsers = [UserViewModel]()
	
	init(service: UserServiceProtocol, delegate: UserPresenterDelegate?) {
		self.service = service
		self.delegate = delegate
	}
	
	func fetchUsers() {
		service.fetchUsers { [weak self] (result) in
			switch result {
				case .failure(let error):
					self?.delegate?.render(errorMessage: error.localizedDescription)
				case .success(let users):
					self?.users = users
					self?.viewUsers = self?.mapToViewUsers(users) ?? []
					self?.delegate?.render(users: self?.viewUsers ?? [])
			}
		}
	}
	
	func sortByName() { }
	
	func sortByAge() { }
	
	private func mapToViewUsers(_ users: [User]) -> [UserViewModel] {
		return users.compactMap({ UserViewModel(name: "\($0.name)-\($0.username)", email: $0.email)})
	}
	
}


protocol UserServiceProtocol {
	func fetchUsers(completion: @escaping(Result<[User], Error>) -> Void)
}

class UserServices: UserServiceProtocol {
	
	func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
		let urlString = "https://jsonplaceholder.typicode.com/users"
		guard let url = URL(string: urlString) else { return }

		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
			}
			
			guard let safeData = data else { return }
			
			do {
				let result = try JSONDecoder().decode([User].self, from: safeData)
				completion(.success(result))
				
			} catch (let error) {
				completion(.failure(error))
			}
			
		}

		task.resume()
	}

}
