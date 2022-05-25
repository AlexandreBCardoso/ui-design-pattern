//
//  ViewController.swift
//  MVPDesignPattern
//
//  Created by Alexandre Cardoso on 26/07/21.
//

import UIKit

class ViewController: UIViewController {
	
	private let tableView: UITableView = {
		let table = UITableView()
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return table
	}()
	
	private let presenter = UserPresenter()
	private var users = [User]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Users"
		
		// TableView
		view.addSubview(tableView)
		tableView.dataSource = self
		tableView.delegate = self
		
		// Presenter
		presenter.setViewDelegate(delegate: self)
		presenter.getUsers()
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
	}
	
}


// MARK: - Extension UITableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let user = users[indexPath.row]
		
		cell.textLabel?.text = user.name
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		// Ask Presenter to handle the tap
		presenter.didTap(user: users[indexPath.row])
	}
	
}


// MARK: - Extension Presenter
extension ViewController: UserPresenterDelegate {
	
	func presentUsers(users: [User]) {
		self.users = users
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	func presentAlert(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		
		present(alertController, animated: true)
	}
	
}
