//
//  LoginWorker.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import Foundation
import Alamofire

typealias loginResponseHandler = (_ response:Login.SignIn.Response) ->()

class LoginWorker {
    
    func login(email:String!, password:String!, responseRequest:@escaping(loginResponseHandler)) {
        if verificaInternet() {
            AF.request(Endpoints.SignIn.url,
                       method: .post,
                       parameters: ["email":email!, "password":password!],
                       encoding: URLEncoding.default).responseData { response in
                switch response.result {
                    case .success(let data):
                        UserDefaults.standard.setOAuth2Session(headerFields: response.response?.allHeaderFields as NSDictionary?)
                        let decoder = JSONDecoder()
                        do {
                            let object = try decoder.decode(Login.SignIn.Response.self, from: data)
                            responseRequest(object)
                        } catch _ {
                            responseRequest(Login.SignIn.Response(success: false, errors: [""]))
                        }
                        break
                    case .failure( _):
                        responseRequest(Login.SignIn.Response(success: false, errors: ["Ops! Ocorreu um erro ao contatar o servidor. Tente mais tarde."]))
                        break
                }
            }
        } else {
            responseRequest(Login.SignIn.Response(success: false, errors: ["Sem conexão com a internet."]))
        }
    }
}
