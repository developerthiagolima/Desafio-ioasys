//
//  EnterprisesPresenter.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

protocol EnterprisesPresentationLogic {
    func presentSearchResults(response: Enterprises.Search.Response)
}

class EnterprisesPresenter: EnterprisesPresentationLogic {
    weak var viewController: EnterprisesDisplayLogic?
    
    func presentSearchResults(response: Enterprises.Search.Response){
        if response.success! {
            viewController?.displayEnterprises(response.enterprises ?? [])
        } else {
            viewController?.displayError(response.error ?? "")
        }
    }
}
