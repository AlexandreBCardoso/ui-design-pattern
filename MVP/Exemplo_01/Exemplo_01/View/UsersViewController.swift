//
//  UsersViewController.swift
//  Exemplo_01
//
//  Created by Alexandre Cardoso on 26/07/21.
//

import UIKit

class UsersViewController: UIViewController {
	
	// MARK: - Variable
	var presenter: UserPresenterProtocol?
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupPresenter()
	}
	
	
	// MARK: - Function
	private func setupPresenter() {
		presenter = UserPresenter(service: UserServices(), delegate: self)
		presenter?.fetchUsers()
	}
	
}


// MARK: - UserPresenter
extension UsersViewController: UserPresenterDelegate {
	
	func render(errorMessage: String) {
	}
	
	func renderLoading() {
	}
	
	func render(users: [UserViewModel]) {
		users.forEach { (user) in
			print("Name: \(user.name)")
			print("Email: \(user.email)")
			print("----------------------------------")
		}
	}
	
}
