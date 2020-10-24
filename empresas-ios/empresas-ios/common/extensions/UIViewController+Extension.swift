//
//  UIViewController+Extension.swift
//  empresas-ios
//
//  Created by Thiago Lima on 21/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertActionCancel = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(alertActionCancel)
        self.present(alert,animated: true)
    }
    
    func showHUD(progressLabel:String){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = progressLabel
    }
    
    func dismissHUD(isAnimated:Bool) {
        MBProgressHUD.hide(for: self.view, animated: isAnimated)
    }
    
    @IBAction public func dismissView(_ sender: AnyObject) {
        _ = self.dismiss(animated: true, completion: nil)
    }
    
}
