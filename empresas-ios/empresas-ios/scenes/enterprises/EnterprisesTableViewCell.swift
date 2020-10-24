//
//  EnterprisesTableViewCell.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit

class EnterprisesTableViewCell: UITableViewCell {
    
    @IBOutlet var lb_nome: UILabel!
    @IBOutlet var img_foto: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepararCell(_ enterprise: Enterprise){
        self.lb_nome.text = enterprise.enterpriseName
        self.img_foto.image = UIImage()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            carregarImagem(imageView: self.img_foto, fileName: "\(enterprise.id).png", pathUrl: enterprise.photo)
        }
    }

}
