//
//  EnterprisesModels.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct Enterprises {
    
    struct Search {
        struct Request {
            var enterprise_types: Int?
            var name: String?
        }
        
        struct Response: Codable {
            var enterprises: [Enterprise]? = []
            var success: Bool? = true
            var error: String? = ""
        }
    }
}
