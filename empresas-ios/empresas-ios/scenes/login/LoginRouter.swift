//
//  LoginRouter.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToEnterprises(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToEnterprises(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! EnterprisesViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func passDataToSomewhere(source: LoginDataStore, destination: inout EnterprisesDataStore) {
        destination.investor = source.investor
    }
}
