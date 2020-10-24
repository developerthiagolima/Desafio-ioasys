//
//  LoginInteractor.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic {
    func login(_ request: Login.SignIn.Request)
}

protocol LoginDataStore {
    var investor: Investor? { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var investor: Investor?
    
    func login(_ request: Login.SignIn.Request) {
        worker = LoginWorker()
        worker?.login(email: request.email!, password: request.password!, responseRequest: { response in
            self.investor = response.investor
            self.presenter?.presentLoginResults(response: response)
        })
    }
}
