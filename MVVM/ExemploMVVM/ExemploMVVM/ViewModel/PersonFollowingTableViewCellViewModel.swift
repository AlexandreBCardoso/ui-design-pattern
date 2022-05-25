//
//  PersonFollowingTableViewCellViewModel.swift
//  ExemploMVVM
//
//  Created by Alexandre Cardoso on 20/04/21.
//

import UIKit


// Estrutura da Célula - Model da Cell
struct PersonFollowingTableViewCellViewModel {
	let name: String
	let username: String
	var currentlyFollowing: Bool
	let image: UIImage?
	
	init(with model: Person) {
		self.name = model.name
		self.username = model.username
		self.currentlyFollowing = false
		self.image = UIImage(systemName: "person")
	}
}
