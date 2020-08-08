//
//  ProductDetailsViewController.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblProductDetailsData: UITableView!
    @IBOutlet weak var btnCart: UIButton!
    var objProducts:Products?
    var objProductDetiailsViewModel = ProductDetailsViewModel()
    var arrColors = [String]()
    var arrSize = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setConfigureData()
    }
    func setConfigureData() {
        self.lblTitle.text = objProducts?.name
        self.tblProductDetailsData.dataSource = self
        self.tblProductDetailsData.delegate = self
        self.tblProductDetailsData.separatorStyle = .none
        self.tblProductDetailsData.tableFooterView = UIView()
        arrColors = (objProducts?.variants?.compactMap{$0.color} as? [String])!
        arrSize = (objProducts?.variants?.compactMap{$0.size} as? [Int])!
        if arrColors.count > 0 {
            objProductDetiailsViewModel.arrSelectionTitle.append("color")
            objProductDetiailsViewModel.arrSelectOption.append("please choose color")
        }
        if arrSize.count > 0 {
            objProductDetiailsViewModel.arrSelectionTitle.append("size")
            objProductDetiailsViewModel.arrSelectOption.append("please choose size")
        }
       
    }
    @IBAction func btnCartClicked(_ sender: Any) {
        Alert().showAlert(message: "Item added Successfuly", viewController: self)
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
