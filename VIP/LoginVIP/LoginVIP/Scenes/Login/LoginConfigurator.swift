//
//  LoginConfigurator.swift
//  LoginVIP
//
//  Created by Alexandre Cardoso on 13/06/22.
//

import UIKit

enum LoginConfigurator {
    
    static func make() -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController") as? LoginViewController
        else { return UIViewController() }
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter)
        let router = LoginRouter()
        
        viewController.interactor = interactor
        presenter.viewController = viewController
        router.dataStore = interactor
        
        
        return viewController
    }
}
