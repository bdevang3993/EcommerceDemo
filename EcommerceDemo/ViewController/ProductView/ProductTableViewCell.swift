//
//  ProductTableViewCell.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 06/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var viewlayer: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        viewlayer.layer.cornerRadius = 14
        viewlayer.layer.shadowColor = UIColor.black.cgColor
        viewlayer.layer.shadowOpacity = 0.3
        viewlayer.layer.shadowOffset = CGSize(width: 0, height: 5)
        viewlayer.layer.masksToBounds = false
    }

}
