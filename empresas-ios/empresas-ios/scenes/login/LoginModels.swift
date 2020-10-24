//
//  LoginModel.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct Login {
    
    struct SignIn {
        struct Request{
            var email: String!
            var password: String!
        }
        
        struct Response : Codable{
            var investor: Investor? = nil
            var enterprise: Enterprise? = nil
            var success: Bool = true
            var errors: [String]? = []
        }
    }

}
