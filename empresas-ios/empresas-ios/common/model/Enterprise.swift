//
//  Enterprise.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct Enterprise: Codable {
    var id: Int = 0
    var emailEnterprise: String? = nil
    var facebook: String? = nil
    var twitter: String? = nil
    var linkedin: String? = nil
    var phone: String? = nil
    var ownEnterprise: Bool = false
    var enterpriseName: String = ""
    var photo: String = ""
    var description: String = ""
    var city: String = ""
    var country: String = ""
    var value: Int = 0
    var sharePrice: Int = 0
    var enterpriseType: EnterpriseType? = nil

    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case emailEnterprise = "email_enterprise"
        case facebook = "facebook"
        case twitter = "twitter"
        case linkedin = "linkedin"
        case phone = "phone"
        case ownEnterprise = "own_enterprise"
        case enterpriseName = "enterprise_name"
        case photo = "photo"
        case description = "description"
        case city = "city"
        case country = "country"
        case value = "value"
        case sharePrice = "share_price"
        case enterpriseType = "enterprise_type"
    }
}
