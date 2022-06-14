//
//  LoginUseCase.swift
//  LoginVIP
//
//  Created by Alexandre Cardoso on 13/06/22.
//

import Foundation

enum LoginUseCase {
    
    enum Validate {
        struct Request {
            let name: String?
            let email: String?
        }
    }
    
    enum Error {
        struct Response {
            let error: Swift.Error
        }
    }
    
}
