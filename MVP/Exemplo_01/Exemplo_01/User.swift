//
//  User.swift
//  Exemplo_01
//
//  Created by Alexandre Cardoso on 26/07/21.
//

import Foundation


// Modelo retornado pelo Backend
struct User: Decodable {
	let id: Int
	let name: String
	let username: String
	let email: String
}


// Modelo com informações necessárias para View
struct UserViewModel {
	let name: String
	let email: String
}
