//
//  EnterprisesWorker.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation
import Alamofire

typealias searchResponseHandler = (_ response:Enterprises.Search.Response) ->()

class EnterprisesWorker {
    
    func search(name: String!, responseRequest:@escaping(searchResponseHandler)) {
        if verificaInternet() {
            AF.request(Endpoints.Enterprise.url,
                   parameters: ["name":name!],
                   headers: UserDefaults.standard.getOAuth2Session()).responseData { response in
            switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        var object = try decoder.decode(Enterprises.Search.Response.self, from: data)
                        object.success = true
                        responseRequest(object)
                    } catch _ {
                        responseRequest(Enterprises.Search.Response(success: false, error: "Ops! Ocorreu um erro ao contatar o servidor. Tente mais tarde."))
                    }
                    break
                case .failure( _):
                    responseRequest(Enterprises.Search.Response(success: false, error: "Ops! Ocorreu um erro ao contatar o servidor. Tente mais tarde."))
                    break
                }
            }
        } else {
            responseRequest(Enterprises.Search.Response(success: false, error: "Sem conexão com a internet."))
        }
    }
}
