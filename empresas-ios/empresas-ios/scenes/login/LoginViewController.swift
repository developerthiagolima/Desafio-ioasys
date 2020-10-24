//
//  LoginViewController.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: class{
    func validateLogin() -> Bool
    func validLogin(_ investor: Investor)
    func displayError(_ error: [String])
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    @IBOutlet var lc_header: NSLayoutConstraint!
    @IBOutlet var iv_header: UIImageView!
    @IBOutlet var lb_title: UILabel!
    @IBOutlet var tf_email: LoginTextField!
    @IBOutlet var tf_pass: LoginTextField!
    var showTitle: Bool = true;
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tf_email.delegate = self
        self.tf_pass.delegate = self
        
//        self.tf_email.text("testeapple@ioasys.com.br")
//        self.tf_pass.text("12341234")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.iv_header.applyCurvedPath(0.3)
    }
    
    private func setup(){
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

extension LoginViewController {
    func hideHeaderView() {
        self.showTitle = false
        toggleHeaderView()
    }
    
    func showHeaderView() {
        self.showTitle = true
        toggleHeaderView()
    }
    
    func toggleHeaderView() {
        if (!self.showTitle) {
            self.lc_header.constant = -70
        } else {
            self.lc_header.constant = 0
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.lb_title.isHidden = !self.showTitle
            self.view.layoutIfNeeded()
        }) {_ in
             self.iv_header.applyCurvedPath(0.3)
        }
    }
    
    func validateLogin() -> Bool{
        self.tf_email.clearState()
        let email = self.tf_email.text()
        if email.isEmpty {
            self.tf_email.addErroState("Informe a sua senha")
            return false
            
        }
        if !email.isValidEmail() {
            self.tf_email.addErroState("Email informado é inválido")
            return false
            
        }
        
        self.tf_pass.clearState()
        let pass = self.tf_pass.text()
        if pass.isEmpty {
            self.tf_pass.addErroState("Informe a sua senha")
            return false
        }
        
        self.view.endEditing(true)
        return true
    }
    
    func validLogin(_ investor: Investor){
        self.dismissHUD(isAnimated: true)
        self.tf_pass.text("")
        self.performSegue(withIdentifier: "Enterprises", sender: nil)
    }
    
    func displayError(_ error: [String]){
        self.dismissHUD(isAnimated: true)
        self.tf_email.addErroState("")
        self.tf_pass.addErroState("Credenciais incorretas")
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        if validateLogin() {
            self.showHUD(progressLabel: "")
            let request = Login.SignIn.Request(email: self.tf_email.text(), password: self.tf_pass.text())
            interactor?.login(request)
        }
    }
}

extension LoginViewController: LoginTextFieldDelegate {
    func didBeginEditing(_ textField: LoginTextField) {
        textField.clearState()
        hideHeaderView()
    }
    func didEndEditing(_ textField: LoginTextField, reason: UITextField.DidEndEditingReason) {
        showHeaderView()
    }
}
