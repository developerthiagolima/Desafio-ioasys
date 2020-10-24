//
//  Endpoints.swift
//  empresas-ios
//
//  Created by Thiago Lima on 21/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "https://empresas.ioasys.com.br"
    static let apiVersion = "/api/v1"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints: Endpoint {
    
    case SignIn
    case Enterprise
    
    public var path: String {
        switch self {
        case .SignIn: return "/users/auth/sign_in"
        case .Enterprise: return "/enterprises"
        }
    }
    public var url: String {
        switch self {
        default: return "\(API.baseUrl)\(API.apiVersion)\(path)"
        }
    }
}
