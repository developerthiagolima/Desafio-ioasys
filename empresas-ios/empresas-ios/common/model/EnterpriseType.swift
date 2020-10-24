//
//  EnterpriseType.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct EnterpriseType: Codable {
    var id: Int = 0
    var enterpriseTypeName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case enterpriseTypeName = "enterprise_type_name"
    }
}
