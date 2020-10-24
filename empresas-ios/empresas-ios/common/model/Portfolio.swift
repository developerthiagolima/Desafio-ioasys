//
//  Portfolio.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct Portfolio: Codable {
    var enterprisesNumber: Int = 0
    var enterprises: [Enterprise] = []
    
    enum CodingKeys: String, CodingKey {
        case enterprisesNumber = "enterprises_number"
        case enterprises = "enterprises"
    }
}
