//
//  PickerTableViewCell.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 06/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {
    var tagSelected:TASenderTag?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet weak var btnPicker: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func btnPickerClicked(_ sender: UIButton) {
        var tag:Int = 0
            tag = sender.tag
        tagSelected!(tag)
    }
    
}
