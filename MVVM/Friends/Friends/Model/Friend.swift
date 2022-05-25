//
//  Friend.swift
//  Friends
//
//  Created by Alexandre Cardoso on 17/06/21.
//

import Foundation

struct Friend: Codable {
	let firstname: String
	let lastname: String
	let phonenumber: String
	let id: Int
}


extension Friend {
	init?(json: JSON) {
		guard let id = json["id"] as? Int,
				let firstname = json["firstname"] as? String,
				let lastname = json["lastname"] as? String,
				let phonenumber = json["phonenumber"] as? String else {
			return nil
		}
		self.id = id
		self.firstname = firstname
		self.lastname = lastname
		self.phonenumber = phonenumber
	}
}
