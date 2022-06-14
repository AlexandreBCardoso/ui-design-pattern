//
//  LoginInteractor.swift
//  LoginVIP
//
//  Created by Alexandre Cardoso on 13/06/22.
//

import Foundation

protocol LoginBusinessLogic {
    func validateData(request: LoginUseCase.Validate.Request)
}

protocol LoginDataStore {
    var name: String? { get set }
}

class LoginInteractor: LoginDataStore {
    var name: String?
    
    private let presenter: LoginPresentationLogic
    
    init(presenter: LoginPresentationLogic) {
        self.presenter = presenter
    }
    
    
}

extension LoginInteractor: LoginBusinessLogic {
    
    func validateData(request: LoginUseCase.Validate.Request) {
        print(#function)
        
        // Verifica se dados são optional
        guard let name = request.name,
              let email = request.email
        else {
            return presenter.presentError()
        }
        
        // Verifica se tem valor
        if name.isEmpty || email.isEmpty {
            presenter.presentError()
        } else {
            self.name = name
            presenter.presentSuccess()
        }
    }
    
}
