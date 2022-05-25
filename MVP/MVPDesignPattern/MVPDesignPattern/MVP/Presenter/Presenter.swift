//
//  Presenter.swift
//  MVPDesignPattern
//
//  Created by Alexandre Cardoso on 26/07/21.
//

import Foundation
import UIKit


protocol UserPresenterDelegate: AnyObject {
	func presentUsers(users: [User])
	func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController


class UserPresenter {
	private weak var delegate: PresenterDelegate?
	
	func setViewDelegate(delegate: PresenterDelegate) {
		self.delegate = delegate
	}
	
	func getUsers() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data, error == nil else { return }
			
			do {
				let users = try JSONDecoder().decode([User].self, from: data)
				self.delegate?.presentUsers(users: users)
			} catch {
				print(error)
			}
		}
		task.resume()
	}
	
	func didTap(user: User) {
//		delegate?.presentAlert(title: user.name,
//									  message: "\(user.name) has an email of \(user.email) & a username of \(user.username)")
		
		// Por o Presenter ser UI (ViewData) podemos fazer assim
		let title = user.name
		let message = "\(user.name) has an email of \(user.email) & a username of \(user.username)"
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		
		delegate?.present(alertController, animated: true)
	}
	
}
