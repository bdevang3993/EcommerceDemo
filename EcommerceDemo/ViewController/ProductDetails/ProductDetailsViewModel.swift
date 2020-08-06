//
//  ProductDetailsViewModel.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ProductDetailsViewModel: NSObject {
    
}

extension ProductDetailsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
             return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tblProductDetailsData.dequeueReusableCell(withIdentifier: "PickerTableViewCell") as! PickerTableViewCell
            cell.lblTitle.text = ""
            cell.lblDescription.text = ""
            return cell
            
        } else {
            let cell = tblProductDetailsData.dequeueReusableCell(withIdentifier: "LableTableViewCell") as! LableTableViewCell
            cell.lblTitle.text = "Price :"
            cell.lblDescription.text = "$" + ""
            return cell
        }
    }
    
    
}
