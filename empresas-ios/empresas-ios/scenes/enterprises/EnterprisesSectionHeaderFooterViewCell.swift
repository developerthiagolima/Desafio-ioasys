//
//  EnterprisesSectionHeaderFooterViewCell.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

class EnterprisesSectionHeaderFooterViewCell: UITableViewCell {

    @IBOutlet var lb_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTitle(_ titulo: String) {
        self.lb_title.text = titulo
    }
}
