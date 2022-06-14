//
//  LoginRouter.swift
//  LoginVIP
//
//  Created by Alexandre Cardoso on 13/06/22.
//

import Foundation

protocol LoginRoutingLogic {
    func routerToHome()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get set }
}

typealias LoginRouterType = LoginRoutingLogic & LoginDataPassing

class LoginRouter: LoginDataPassing {
    var dataStore: LoginDataStore?
    
}

extension LoginRouter: LoginRoutingLogic {
    
    func routerToHome() {
        // Passar o Nome digitado para a Home
        // Chamar a Home
    }
    
}
