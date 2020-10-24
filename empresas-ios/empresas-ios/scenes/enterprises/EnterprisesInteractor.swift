//
//  EnterprisesInteractor.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

protocol EnterprisesBusinessLogic {
    func search(_ request: Enterprises.Search.Request)
    func select(_ enterprise: Enterprise)
}

protocol EnterprisesDataStore {
    var investor: Investor? { get set }
    var enterprise: Enterprise? { get set }
}

class EnterprisesInteractor: EnterprisesBusinessLogic, EnterprisesDataStore {
    var presenter: EnterprisesPresentationLogic?
    var worker: EnterprisesWorker?
    var enterprise: Enterprise?
    var investor: Investor?
    
    func search(_ request: Enterprises.Search.Request) {
        worker = EnterprisesWorker()
        worker?.search(name: request.name ?? "", responseRequest: { response in
            self.presenter?.presentSearchResults(response: response)
        })
    }
    
    func select(_ enterprise: Enterprise) {
        self.enterprise = enterprise
    }
}
