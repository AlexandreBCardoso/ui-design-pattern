//
//  ViewController.swift
//  ExemploMVVM
//
//  Created by Alexandre Cardoso on 20/04/21.
//

import UIKit

class ViewController: UIViewController {
	
	private var employeeViewModel: EmployeesViewModel!
//	private var dataSource: EmployeeTableViewDataSource<EmployeeTableViewDataSource, EmployeeData>
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	func callToViewModelForUIUpdate() {
		self.employeeViewModel = EmployeesViewModel()
		self.employeeViewModel.bindEmployeeViewModelToController = {
			
		}
	}
	
	func updateDataSource() {
		
	}
	
	
}

