//
//  EnterprisesRouter.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

@objc protocol EnterprisesRoutingLogic {
    func routeToEnterpriseDetail(segue: UIStoryboardSegue?)
}

protocol EnterprisesDataPassing {
    var dataStore: EnterprisesDataStore? { get }
}

class EnterprisesRouter: NSObject, EnterprisesRoutingLogic, EnterprisesDataPassing {
    weak var viewController: EnterprisesViewController?
    var dataStore: EnterprisesDataStore?
    
    func routeToEnterpriseDetail(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! EnterpriseDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func passDataToSomewhere(source: EnterprisesDataStore, destination: inout EnterpriseDetailDataStore) {
        destination.enterprise = source.enterprise
    }
}
