//
//  CategoryTableViewCell.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var viewLayer: UIView!
    @IBOutlet weak var lblCompanyName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        viewLayer.layer.cornerRadius = 14
        viewLayer.layer.shadowColor = UIColor.black.cgColor
        viewLayer.layer.shadowOpacity = 0.3
        viewLayer.layer.shadowOffset = CGSize(width: 0, height: 5)
        viewLayer.layer.masksToBounds = false
    }

}
