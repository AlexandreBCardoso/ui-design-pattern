//
//  LoginViewController.swift
//  LoginVIP
//
//  Created by Alexandre Cardoso on 13/06/22.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displaySuccess()
    func displayError()
}

final class LoginViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: LoginRouterType?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func tappedContinueButton(_ sender: UIButton) {
        interactor?.validateData(
            request: .init(
                name: nameTextField.text,
                email: emailTextField.text
            )
        )
    }

}

extension LoginViewController: LoginDisplayLogic {
    
    func displaySuccess() {
        print(#function)
    }
    
    func displayError() {
        print(#function)
        let alert = UIAlertController(
            title: "Erro",
            message: "Nome ou E-mail errado",
            preferredStyle: .alert
        )
        let OKAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(OKAction)
        
        present(alert, animated: true)
    }
    
}
