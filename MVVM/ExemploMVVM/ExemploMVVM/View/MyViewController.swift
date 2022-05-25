//
//  MyViewController.swift
//  ExemploMVVM
//
//  Created by Alexandre Cardoso on 20/04/21.
//

import UIKit

class MyViewController: UIViewController {
	
	private var models = [Person]()
	
	private let tableView: UITableView = {
		let table = UITableView()
		table.register(PersonFollowingTableViewCell.self,
							forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
		
		return table
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(tableView)
		
		configureModels()
		
		tableView.dataSource = self
		tableView.frame = view.bounds
	}
	
	private func configureModels() {
		let names = ["Felipe", "Caio", "Alexandre", "Danilo", "Tonon", "Lucas", "Junior"]
		for name in names {
			self.models.append(Person(name: name))
		}
	}
	
}


extension MyViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.row]
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingTableViewCell.identifier,
															  for: indexPath) as? PersonFollowingTableViewCell
		else { return UITableViewCell() }
		
		cell.configure(with: PersonFollowingTableViewCellViewModel(with: model))
		cell.delegate = self
		return cell
	}
	
}


extension MyViewController: PersonFollowingTableViewCellDelegate {
	
	func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell,
												 didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
		
	}
	
}
