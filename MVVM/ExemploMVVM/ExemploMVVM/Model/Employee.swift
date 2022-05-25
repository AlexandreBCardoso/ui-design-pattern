//
//  Employee.swift
//  ExemploMVVM
//
//  Created by Alexandre Cardoso on 20/04/21.
//

import Foundation

struct Employee: Decodable {
	let status: String
	let data: [EmployeeData]
}

struct EmployeeData: Decodable {
	let id, employeeName, employeeSalary, employeeAge: String
	let profileImage: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case employeeName = "employee_name"
		case employeeSalary = "employee_salary"
		case employeeAge = "employee_age"
		case profileImage = "profile_image"
	}
}
