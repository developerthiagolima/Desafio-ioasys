//
//  UserDefaults+Extension.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation
import Alamofire

extension UserDefaults{
    
    enum OAuth2DefaultKeys: String {
        case accessToken = "access-token", client, uid
        static let allValues = [accessToken, client, uid]
    }
    
    func setOAuth2Session(headerFields: NSDictionary?){
        if let headers = headerFields {
            OAuth2DefaultKeys.allValues.forEach({ key in
                UserDefaults.standard.set(headers[key.rawValue], forKey: key.rawValue)
            })
            synchronize()
        }
    }
    
    func getOAuth2Session() -> HTTPHeaders{
        var headers: HTTPHeaders = []
        OAuth2DefaultKeys.allValues.forEach({ key in
            headers[key.rawValue] = UserDefaults.standard.string(forKey: key.rawValue) ?? ""
        })
        return headers
    }
}
