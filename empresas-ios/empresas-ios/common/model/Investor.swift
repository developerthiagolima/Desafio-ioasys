//
//  Investor.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct Investor: Codable {
    var id: Int = 0
    var investorName: String = ""
    var email: String = ""
    var city: String = ""
    var balance: Int = 0
    var photo: String? = nil
    var portfolio: Portfolio? = nil
    var portfolioValue: Int = 0
    var firtAccess: Bool = false
    var superAngel: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case investorName = "investor_name"
        case email = "email"
        case city = "city"
        case balance = "balance"
        case photo = "photo"
        case portfolio = "portfolio"
        case portfolioValue = "portfolio_value"
        case firtAccess = "first_access"
        case superAngel = "super_angel"
    }
}
