//
//  LoginTextField.swift
//  empresas-ios
//
//  Created by Thiago Lima on 21/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

@objc protocol LoginTextFieldDelegate {
    @objc optional func didBeginEditing(_ textField: LoginTextField)
    @objc optional func didEndEditing(_ textField: LoginTextField, reason: UITextField.DidEndEditingReason)
}

@IBDesignable
class LoginTextField: UIView {
    
    @objc enum TextFieldTypeEnum: Int {
        case email = 1
        case senha = 2
    }
    
    var typeTextFiled: TextFieldTypeEnum? {
        didSet {
            self.updateTextFieldView()
        }
    }
    
    var delegate: LoginTextFieldDelegate?
    
    @IBOutlet weak var img_error: UIImageView!
    @IBOutlet weak var vw_input: UIView!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_error: UILabel!
    @IBOutlet weak var tf_input: UITextField!
    @IBOutlet weak var btn_ocultar: UIButton!
    var showPassword: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    @IBInspectable var label: String = "" {
        didSet {
            lb_title.text = label;
        }
    }
    
    @IBInspectable var isPassword: Bool {
        get {
            return typeTextFiled == .senha
        }
        set {
            self.typeTextFiled = newValue ? .senha : .email
        }
    }
    
    func updateTextFieldView() {
        if (self.typeTextFiled == .email) {
            self.btn_ocultar.isHidden = true
            self.tf_input.keyboardType  = .emailAddress
        } else {
            self.btn_ocultar.isHidden = false
            self.tf_input.keyboardType  = .asciiCapable
            self.showPassword = false
            self.tf_input.isSecureTextEntry = !self.showPassword
        }
    }
    
    @discardableResult
    func text(_ newValue: String? = nil) -> String {
        if (newValue != nil) {
            self.tf_input.text = newValue
        }
        return self.tf_input.text ?? ""
    }
    
    @IBAction func toggleShowPassword() {
        self.showPassword.toggle()
        self.tf_input.isSecureTextEntry = !self.showPassword
        self.showPassword ? self.btn_ocultar.setImage(UIImage(named: "eye_hide"), for: .normal) : self.btn_ocultar.setImage(UIImage(named: "eye"), for: .normal)
        
    }
    
    func forceHidePassword(){
        self.showPassword = false
        self.tf_input.isSecureTextEntry = !self.showPassword
        self.showPassword ? self.btn_ocultar.setImage(UIImage(named: "eye_hide"), for: .normal) : self.btn_ocultar.setImage(UIImage(named: "eye"), for: .normal)
    }
    
    func addErroState(_ msg: String) {
        self.lb_error.text = msg
        self.btn_ocultar.alpha = 0
        self.vw_input.borderWidth = 1
        self.vw_input.borderColor = UIColor(hexString: "E00000")
        self.img_error.isHidden = false
    }
    
    func clearState() {
        if (typeTextFiled == .senha) {
            self.forceHidePassword()
        }
        self.lb_error.text = ""
        self.btn_ocultar.alpha = 1
        self.vw_input.borderWidth = 0
        self.vw_input.borderColor = UIColor.clear
        self.img_error.isHidden = true
    }
}

extension LoginTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (delegate?.didBeginEditing != nil) {
            delegate?.didBeginEditing!(self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (delegate?.didEndEditing != nil) {
            delegate?.didEndEditing!(self, reason: reason)
        }
    }
}
