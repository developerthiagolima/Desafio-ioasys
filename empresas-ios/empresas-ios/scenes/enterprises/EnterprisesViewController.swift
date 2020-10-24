//
//  EnterprisesViewController.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

protocol EnterprisesDisplayLogic: class{
    func displayEnterprises(_ enterprises: [Enterprise])
    func displayError(_ error: String)
}

class EnterprisesViewController: UIViewController, EnterprisesDisplayLogic {
    var interactor: EnterprisesBusinessLogic?
    var router: (NSObjectProtocol & EnterprisesRoutingLogic & EnterprisesDataPassing)?
    
    @IBOutlet var tabela: UITableView!
    @IBOutlet var tf_search: UITextField!
    var enterprises: [Enterprise]? = nil
    
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
    }
    
    private func setup(){
        let viewController = self
        let interactor = EnterprisesInteractor()
        let presenter = EnterprisesPresenter()
        let router = EnterprisesRouter()
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

extension EnterprisesViewController {
    
    func realizarPesquisa() {
        self.showHUD(progressLabel: "")
        self.interactor!.search(Enterprises.Search.Request(enterprise_types: nil, name: self.tf_search.text!))
    }
    
    func displayEnterprises(_ enterprises: [Enterprise]){
        self.dismissHUD(isAnimated: true)
        self.enterprises = enterprises
        self.tabela.reloadData()
    }
    
    func displayError(_ error: String){
        self.dismissHUD(isAnimated: true)
        self.showAlert(title: "Empresas", message: error)
    }
    
}

extension EnterprisesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.realizarPesquisa()
        return true
    }
}

extension EnterprisesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.enterprises != nil) {
            return self.enterprises!.isEmpty ? 1 : self.enterprises!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.enterprises!.isEmpty) {
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell")!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnterpriseCell", for: indexPath) as! EnterprisesTableViewCell
            cell.prepararCell(self.enterprises![indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (self.enterprises != nil && !self.enterprises!.isEmpty) {
            let view = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! EnterprisesSectionHeaderFooterViewCell
            view.setTitle("\(self.enterprises!.count) resultados encontrados")
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor!.select(self.enterprises![indexPath.row])
        self.performSegue(withIdentifier: "EnterpriseDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.enterprises!.isEmpty) {
            return 370.0
        } else {
            return 140.0
        }
    }
    
}
