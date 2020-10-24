//
//  LoginPresenter.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

protocol LoginPresentationLogic {
    func presentLoginResults(response: Login.SignIn.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginResults(response: Login.SignIn.Response){
        if response.success {
            viewController?.validLogin(response.investor!)
        } else {
            viewController?.displayError(response.errors!)
        }
    }
}
