//
//  ViewController.swift
//  MVVM-Bindings
//
//  Created by Alexandre Cardoso on 22/06/21.
//

import UIKit

// Observable
class Observable<T> {
	private var listener: ((T?) -> Void)?
	
	var value: T? {
		didSet {
			listener?(value)
		}
	}
	
	init(_ value: T?) {
		self.value = value
	}
	
	func bind(_ listener: @escaping(T?) -> Void) {
		listener(value)
		self.listener = listener
	}
	
}

// View Model
struct UserListViewModel {
	var users: Observable<[UserTableViewCellViewModel]> = Observable([])
}

struct UserTableViewCellViewModel {
	let name: String
}



class ViewController: UIViewController {
	
	private let tableView: UITableView = {
		let table = UITableView()
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return table
	}()
	
	private let viewModel = UserListViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.dataSource = self
		
		viewModel.users.bind { [weak self] _ in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
		
		fetchData()
	}
	
	func fetchData() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
		
		let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }
			
			do {
				let userModels = try JSONDecoder().decode([User].self, from: data)
				self.viewModel.users.value = userModels.map({UserTableViewCellViewModel(name: $0.name)})
			} catch {
				print(error.localizedDescription)
			}
		}
		task.resume()
	}
	
}


extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.users.value?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = viewModel.users.value?[indexPath.row].name
		return cell
	}
	
}
