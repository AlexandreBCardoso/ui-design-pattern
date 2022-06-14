//
//  LoginPresenter.swift
//  LoginVIP
//
//  Created by Alexandre Cardoso on 13/06/22.
//

import Foundation

protocol LoginPresentationLogic {
    func presentSuccess()
    func presentError()
}

class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {

    func presentSuccess() {
        print(#function)
        
        viewController?.displaySuccess()
    }
    
    func presentError() {
        print(#function)
        
        viewController?.displayError()
    }
    
}
