//
//  EnterpriseDetailRouter.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright (c) 2020 ioasys. All rights reserved.
//

import UIKit

@objc protocol EnterpriseDetailRoutingLogic {
}

protocol EnterpriseDetailDataPassing {
    var dataStore: EnterpriseDetailDataStore? { get }
}

class EnterpriseDetailRouter: NSObject, EnterpriseDetailRoutingLogic, EnterpriseDetailDataPassing {
    weak var viewController: EnterpriseDetailViewController?
    var dataStore: EnterpriseDetailDataStore?
}
