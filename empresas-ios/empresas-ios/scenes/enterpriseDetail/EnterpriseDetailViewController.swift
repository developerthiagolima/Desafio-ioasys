//
//  EnterpriseDetailViewController.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright (c) 2020 ioasys. All rights reserved.
//

import UIKit

class EnterpriseDetailViewController: UIViewController {
    var interactor: EnterpriseDetailBusinessLogic?
    var router: (NSObjectProtocol & EnterpriseDetailRoutingLogic & EnterpriseDetailDataPassing)?
    
    @IBOutlet var lb_title: UILabel!
    @IBOutlet var img_enterprise: UIImageView!
    @IBOutlet var lb_descricao: UILabel!
    
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
        displayEnterprise(self.interactor!.getEnterprise())
    }
    
    private func setup() {
        let viewController = self
        let interactor = EnterpriseDetailInteractor()
        let router = EnterpriseDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

extension EnterpriseDetailViewController {
    
    func displayEnterprise(_ enterprise: Enterprise!) {
        self.lb_title.text = enterprise.enterpriseName
        self.lb_descricao.text = enterprise.description
        carregarImagem(imageView:self.img_enterprise, fileName: "\(enterprise.id).png", pathUrl: enterprise.photo)
    }
}
