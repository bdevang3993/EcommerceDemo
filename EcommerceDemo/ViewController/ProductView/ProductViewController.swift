//
//  ProductViewController.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var btnSortBy: UIButton!
    @IBOutlet weak var tblProductDisplay: UITableView!
    @IBOutlet weak var lblProductData: UILabel!
    var objCategoryModel:CategoryModel?
    var objCategory:Categories?
    var objProductViewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setConfigData()
    }
    func setConfigData() {
        tblProductDisplay.delegate = self
        tblProductDisplay.dataSource = self
        tblProductDisplay.tableFooterView = UIView()
        tblProductDisplay.separatorStyle = .none
        searchView.delegate = self
        searchView.searchTextField.delegate = self
        objProductViewModel.arrProducts = objCategory?.products as! [Products]
        objProductViewModel.arrSearchProducts = objProductViewModel.arrProducts
        if objProductViewModel.arrSearchProducts.count <= 0 {
            var subCategoryes = [Int]()
            if let allData = objCategory?.child_categories {
                subCategoryes = allData
            }
            objProductViewModel.arrProducts.removeAll()
            let arrAllCategories:[Categories] = (objCategoryModel?.categories)!
            if subCategoryes.count > 0 {
                for productid in subCategoryes {
                    for category in arrAllCategories {
                        if productid == category.id {
                            for productData in category.products! {
                                objProductViewModel.arrProducts.append(productData)
                            }
                        }
                    }
                    
                }
                objProductViewModel.arrSearchProducts = objProductViewModel.arrProducts
            }
        }
        let data = objCategoryModel?.rankings
        let names = data?.compactMap{$0.ranking}
        if names != nil {
            objProductViewModel.arrSortBy = names!
            print("Data = \(objProductViewModel.arrSortBy)")
        }
        self.tblProductDisplay.reloadData()
    }
    
    @IBAction func btnSortByClicked(_ sender: Any) {
        
        self.setUpPicker(arrPickerData: objProductViewModel.arrSortBy)
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
