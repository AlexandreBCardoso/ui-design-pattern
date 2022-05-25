//
//  EmployeesViewModel.swift
//  ExemploMVVM
//
//  Created by Alexandre Cardoso on 20/04/21.
//

import Foundation

class EmployeesViewModel: NSObject {
	
	private var apiService: APIService!
	
	private(set) var empData: Employee! {
		didSet {
			self.bindEmployeeViewModelToController()
		}
	}
	
	var bindEmployeeViewModelToController: (() -> ()) = {}
	
	
	override init() {
		super.init()
		self.apiService = APIService()
		callFuncToGetEmpData()
	}
	
	func callFuncToGetEmpData() {
		self.apiService.apiToGetEmployeeData { (empData) in
			print(empData)
		}
	}
	
}
